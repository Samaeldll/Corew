/*
<<<<<<< HEAD
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
=======
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
>>>>>>> master
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
<<<<<<< HEAD
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
=======
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
>>>>>>> master
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef AUCHENAI_CRYPTS_H_
#define AUCHENAI_CRYPTS_H_

#include "CreatureAIImpl.h"

#define ACScriptName "instance_auchenai_crypts"
#define DataHeader   "AC"

uint32 const EncounterCount = 2;

enum ACDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_SHIRRAK_THE_DEAD_WATCHER   = 0,
    DATA_EXARCH_MALADAAR            = 1
};

template <class AI, class T>
inline AI* GetAuchenaiCryptsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ACScriptName);
}

#endif // AUCHENAI_CRYPTS_H_
