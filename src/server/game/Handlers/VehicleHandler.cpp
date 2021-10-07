/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "Vehicle.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleDismissControlledVehicle(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_DISMISS_CONTROLLED_VEHICLE");

    ObjectGuid vehicleGUID = _player->GetCharmGUID();

    if (!vehicleGUID)                                       // something wrong here...
    {
        recvData.rfinish();                                // prevent warnings spam
        return;
    }

    ObjectGuid guid;
    recvData >> guid.ReadAsPacked();

    // pussywizard: typical check for incomming movement packets
    if (!_player->m_mover || !_player->m_mover->IsInWorld() || _player->m_mover->IsDuringRemoveFromWorld() || guid != _player->m_mover->GetGUID())
    {
        recvData.rfinish(); // prevent warnings spam
        _player->ExitVehicle();
        return;
    }

    MovementInfo mi;
    mi.guid = guid;
    ReadMovementInfo(recvData, &mi);

    _player->m_mover->m_movementInfo = mi;

    _player->ExitVehicle();
}

void WorldSession::HandleChangeSeatsOnControlledVehicle(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE");

    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
    {
        recvData.rfinish();                                // prevent warnings spam
        return;
    }

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        recvData.rfinish();                                // prevent warnings spam
        LOG_ERROR("network.opcode", "HandleChangeSeatsOnControlledVehicle, Opcode: {}, Player {} tried to switch seats but current seatflags {} don't permit that.",
                       recvData.GetOpcode(), GetPlayer()->GetGUID(), seat->m_flags);
        return;
    }

    switch (recvData.GetOpcode())
    {
        case CMSG_REQUEST_VEHICLE_PREV_SEAT:
            GetPlayer()->ChangeSeat(-1, false);
            break;
        case CMSG_REQUEST_VEHICLE_NEXT_SEAT:
            GetPlayer()->ChangeSeat(-1, true);
            break;
        case CMSG_CHANGE_SEATS_ON_CONTROLLED_VEHICLE:
            {
                ObjectGuid guid;        // current vehicle guid
                recvData >> guid.ReadAsPacked();

                // pussywizard:
                if (vehicle_base->GetGUID() != guid)
                {
                    recvData.rfinish(); // prevent warnings spam
                    return;
                }

                MovementInfo movementInfo;
                movementInfo.guid = guid;
                ReadMovementInfo(recvData, &movementInfo);
                vehicle_base->m_movementInfo = movementInfo;

                ObjectGuid accessory;        //  accessory guid
                recvData >> accessory.ReadAsPacked();

                int8 seatId;
                recvData >> seatId;

                if (!accessory)
                    GetPlayer()->ChangeSeat(-1, seatId > 0); // prev/next
                else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), accessory))
                {
                    if (Vehicle* vehicle = vehUnit->GetVehicleKit())
                        if (vehicle->HasEmptySeat(seatId))
                            vehUnit->HandleSpellClick(GetPlayer(), seatId);
                }
                break;
            }
        case CMSG_REQUEST_VEHICLE_SWITCH_SEAT:
            {
                ObjectGuid guid;        // current vehicle guid
                recvData >> guid.ReadAsPacked();

                int8 seatId;
                recvData >> seatId;

                if (vehicle_base->GetGUID() == guid)
                    GetPlayer()->ChangeSeat(seatId);
                else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), guid))
                    if (Vehicle* vehicle = vehUnit->GetVehicleKit())
                        if (vehicle->HasEmptySeat(seatId))
                            vehUnit->HandleSpellClick(GetPlayer(), seatId);
                break;
            }
        default:
            break;
    }
}

void WorldSession::HandleEnterPlayerVehicle(WorldPacket& data)
{
    // Read guid
    ObjectGuid guid;
    data >> guid;

    if (Player* player = ObjectAccessor::GetPlayer(*_player, guid))
    {
        if (!player->GetVehicleKit())
            return;
        if (!player->IsInRaidWith(_player))
            return;
        if (!player->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
            return;
        // Xinef:
        if (!_player->FindMap() || _player->FindMap()->IsBattleArena())
            return;

        _player->EnterVehicle(player);
    }
}

void WorldSession::HandleEjectPassenger(WorldPacket& data)
{
    Vehicle* vehicle = _player->GetVehicleKit();
    if (!vehicle)
    {
        data.rfinish();                                     // prevent warnings spam
        LOG_ERROR("network.opcode", "HandleEjectPassenger: Player {} is not in a vehicle!", GetPlayer()->GetGUID().ToString());
        return;
    }

    ObjectGuid guid;
    data >> guid;

    if (guid.IsPlayer())
    {
        Player* player = ObjectAccessor::GetPlayer(*_player, guid);
        if (!player)
        {
            LOG_ERROR("network.opcode", "Player {} tried to eject player {} from vehicle, but the latter was not found in world!", GetPlayer()->GetGUID().ToString(), guid.ToString());
            return;
        }

        if (!player->IsOnVehicle(vehicle->GetBase()))
        {
            LOG_ERROR("network.opcode", "Player {} tried to eject player {}, but they are not in the same vehicle", GetPlayer()->GetGUID().ToString(), guid.ToString());
            return;
        }

        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(player);
        ASSERT(seat);
        if (seat->IsEjectable())
            player->ExitVehicle();
        else
            LOG_ERROR("network.opcode", "Player {} attempted to eject player {} from non-ejectable seat.", GetPlayer()->GetGUID().ToString(), guid.ToString());
    }
    else if (guid.IsCreature())
    {
        Unit* unit = ObjectAccessor::GetUnit(*_player, guid);
        if (!unit) // creatures can be ejected too from player mounts
        {
            LOG_ERROR("network.opcode", "Player {} tried to eject creature guid {} from vehicle, but the latter was not found in world!", GetPlayer()->GetGUID().ToString(), guid.ToString());
            return;
        }

        if (!unit->IsOnVehicle(vehicle->GetBase()))
        {
            LOG_ERROR("network.opcode", "Player {} tried to eject unit {}, but they are not in the same vehicle", GetPlayer()->GetGUID().ToString(), guid.ToString());
            return;
        }

        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(unit);
        ASSERT(seat);
        if (seat->IsEjectable())
        {
            ASSERT(GetPlayer() == vehicle->GetBase());
            unit->ExitVehicle();
        }
        else
            LOG_ERROR("network.opcode", "Player {} attempted to eject creature {} from non-ejectable seat.", GetPlayer()->GetGUID().ToString(), guid.ToString());
    }
    else
        LOG_ERROR("network.opcode", "HandleEjectPassenger: Player {} tried to eject invalid {}", GetPlayer()->GetGUID().ToString(), guid.ToString());
}

void WorldSession::HandleRequestVehicleExit(WorldPacket& /*recvData*/)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_REQUEST_VEHICLE_EXIT");

    if (Vehicle* vehicle = GetPlayer()->GetVehicle())
    {
        if (VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(GetPlayer()))
        {
            if (seat->CanEnterOrExit())
                GetPlayer()->ExitVehicle();
            else
                LOG_ERROR("network.opcode", "Player {} tried to exit vehicle, but seatflags {} (ID: {}) don't permit that.",
                               GetPlayer()->GetGUID(), seat->m_ID, seat->m_flags);
        }
    }
}
