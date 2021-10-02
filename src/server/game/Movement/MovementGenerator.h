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

#ifndef WARHEAD_MOVEMENTGENERATOR_H
#define WARHEAD_MOVEMENTGENERATOR_H

#include "Common.h"
#include "Define.h"
#include "FactoryHolder.h"
#include "MotionMaster.h"
#include "ObjectRegistry.h"

class Unit;

class WH_GAME_API MovementGenerator
{
public:
    virtual ~MovementGenerator();

    virtual void Initialize(Unit*) = 0;
    virtual void Finalize(Unit*) = 0;

    virtual void Reset(Unit*) = 0;

    virtual bool Update(Unit*, uint32 time_diff) = 0;

    virtual MovementGeneratorType GetMovementGeneratorType() = 0;

    virtual uint32 GetSplineId() const { return 0; }  // Xinef: Escort system

    virtual void unitSpeedChanged() { }

    // used by Evade code for select point to evade with expected restart default movement
    virtual bool GetResetPosition(float& /*x*/, float& /*y*/, float& /*z*/) { return false; }
};

template<class T, class D>
class MovementGeneratorMedium : public MovementGenerator
{
public:
    void Initialize(Unit* u) override
    {
        //u->AssertIsType<T>();
        (static_cast<D*>(this))->DoInitialize(static_cast<T*>(u));
    }

    void Finalize(Unit* u) override
    {
        //u->AssertIsType<T>();
        (static_cast<D*>(this))->DoFinalize(static_cast<T*>(u));
    }

    void Reset(Unit* u) override
    {
        //u->AssertIsType<T>();
        (static_cast<D*>(this))->DoReset(static_cast<T*>(u));
    }

    bool Update(Unit* u, uint32 time_diff) override
    {
        //u->AssertIsType<T>();
        return (static_cast<D*>(this))->DoUpdate(static_cast<T*>(u), time_diff);
    }
};

struct SelectableMovement : public FactoryHolder<MovementGenerator, MovementGeneratorType>
{
    SelectableMovement(MovementGeneratorType mgt) : FactoryHolder<MovementGenerator, MovementGeneratorType>(mgt) {}
};

template<class REAL_MOVEMENT>
struct MovementGeneratorFactory : public SelectableMovement
{
    MovementGeneratorFactory(MovementGeneratorType mgt) : SelectableMovement(mgt) {}

    MovementGenerator* Create(void*) const;
};

typedef FactoryHolder<MovementGenerator, MovementGeneratorType> MovementGeneratorCreator;
typedef FactoryHolder<MovementGenerator, MovementGeneratorType>::FactoryHolderRegistry MovementGeneratorRegistry;
#endif
