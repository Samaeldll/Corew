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

#ifndef _FOLLOWERREFERENCE_H
#define _FOLLOWERREFERENCE_H

#include "Reference.h"

class TargetedMovementGeneratorBase;
class Unit;

class WH_GAME_API FollowerReference : public Reference<Unit, TargetedMovementGeneratorBase>
{
protected:
    void targetObjectBuildLink() override;
    void targetObjectDestroyLink() override;
    void sourceObjectDestroyLink() override;
};
#endif
