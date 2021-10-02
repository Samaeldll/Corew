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

/**
 *
 * Utility library to define some global function for simple physics calculations
 *
 */

#ifndef _WARHEAD_PHYSICS_H
#define _WARHEAD_PHYSICS_H

#include "Geometry.h"
#include <cmath>
#include <cstdlib>
#include <iostream>

using namespace std;

[[nodiscard]] inline float getWeight(float height, float width, float specificWeight)
{
    auto volume = getCylinderVolume(height, width / 2.0f);
    auto weight = volume * specificWeight;
    return weight;
}

/**
 * @brief Get the height immersed in water
 *
 * @param height
 * @param width
 * @param weight specific weight
 * @return float
 */
[[nodiscard]] inline float getOutOfWater(float width, float weight, float density)
{
    auto baseArea = getCircleAreaByRadius(width / 2.0f);
    return weight / (baseArea * density);
}

#endif // _WARHEAD_PHYSICS_H
