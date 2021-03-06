-- DB update 2022_06_18_03 -> 2022_06_18_04
--
DELETE FROM `pool_template` WHERE `entry` IN (391, 392, 393); 
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (391, 4, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (392, 4, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (393, 4, 'Brontus Kodo Pack Combo 3 -- Brontus Pack');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (394, 1, 'Brontus Kodo Pack Pool of Pools');

DELETE FROM `creature` WHERE `guid` IN (51815);
/* Combo 1 */
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(45809, 3236, 0, 0, 1, 0, 0, 1, 1, 0, -3787.7153, -1848.3755, 93.918015, 2.55345463752746582, 600, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- .go xyz -3787.7153 -1848.3755 93.918015 Leader 
(45810, 3236, 0, 0, 1, 0, 0, 1, 1, 0, -3814.7678, -1845.9219, 93.61283, 0.949117600917816162, 600, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45811, 3236, 0, 0, 1, 0, 0, 1, 1, 0, -3798.8208, -1829.7017, 94.17238, 4.366050243377685546, 600, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45812, 3236, 0, 0, 1, 0, 0, 1, 1, 0, -3807.5981, -1865.3707, 92.56358, 1.319851279258728027, 600, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
/* Combo 2 */
(45813, 3235, 3236, 0, 1, 0, 0, 1, 1, 0, -3787.7153, -1848.3755, 93.918015, 2.55345463752746582, 900, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- .go xyz -3787.7153 -1848.3755 93.918015 Leader 
(45814, 3237, 3236, 0, 1, 0, 0, 1, 1, 0, -3814.7678, -1845.9219, 93.61283, 0.949117600917816162, 900, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45815, 3237, 3236, 0, 1, 0, 0, 1, 1, 0, -3798.8208, -1829.7017, 94.17238, 4.366050243377685546, 900, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45816, 3235, 3236, 0, 1, 0, 0, 1, 1, 0, -3807.5981, -1865.3707, 92.56358, 1.319851279258728027, 900, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
/* Combo 3 */
(45817, 3237, 0, 0, 1, 0, 0, 1, 1, 0, -3787.7153, -1848.3755, 93.918015, 2.55345463752746582, 1800, 0, 0, 1, 0, 2, 0, 0, 0, '', 0), -- .go xyz -3787.7153 -1848.3755 93.918015 Leader 
(45818, 5827, 0, 0, 1, 0, 0, 1, 1, 0, -3814.7678, -1845.9219, 93.61283, 0.949117600917816162, 1800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45819, 3235, 0, 0, 1, 0, 0, 1, 1, 0, -3798.8208, -1829.7017, 94.17238, 4.366050243377685546, 1800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(45820, 3236, 0, 0, 1, 0, 0, 1, 1, 0, -3807.5981, -1865.3707, 92.56358, 1.319851279258728027, 1800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `pool_creature` WHERE `guid` IN (45809, 45810, 45811, 45812, 45813, 45814, 45815, 45816, 45817, 45818, 45819, 45820);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `description`) VALUES 
(45809, 391, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack Leader Mob'),
(45810, 391, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack'),
(45811, 391, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack'),
(45812, 391, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack'),
(45813, 392, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack Leader Mob'),
(45814, 392, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack'),
(45815, 392, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack'),
(45816, 392, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack'),
(45817, 393, 'Brontus Kodo Pack Combo 3 -- Brontus Pack Leader Mob'),
(45818, 393, 'Brontus Kodo Pack Combo 3 -- Brontus Pack'),
(45819, 393, 'Brontus Kodo Pack Combo 3 -- Brontus Pack'),
(45820, 393, 'Brontus Kodo Pack Combo 3 -- Brontus Pack');

DELETE FROM `pool_pool` WHERE `pool_id` IN (391, 392, 393);
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(391, 394, 55, 'Brontus Kodo Pack Combo 1 -- 4 Barrens Kodo Pack'),
(392, 394, 30, 'Brontus Kodo Pack Combo 2 -- Mixed Kodo Pack'),
(393, 394, 15, 'Brontus Kodo Pack Combo 3 -- Brontus Pack');

-- Pathing for Kodos with Brontus
SET @NPC := 45809;
SET @path := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid` IN (@NPC, @NPC+4, @NPC+8);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@path,0,0,1,0,0, ''),
(@NPC+4,@path,0,0,1,0,0, ''),
(@NPC+8,@path,0,0,1,0,0, '');

DELETE FROM `waypoint_data` WHERE `id`=@path;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@path,1,-3780.6667,-1879.9966,94.51902,0,0,0,0,100,0),
(@path,2,-3765.317,-1912.2642,92.659584,0,0,0,0,100,0),
(@path,3,-3743.7683,-1944.3379,93.25019,0,0,0,0,100,0),
(@path,4,-3718.9587,-1949.9241,94.24338,0,0,0,0,100,0),
(@path,5,-3674.7666,-1972.0784,92.34276,0,0,0,0,100,0),
(@path,6,-3633.491,-1962.7506,91.96043,0,0,0,0,100,0),
(@path,7,-3604.3447,-1934.8683,93.6461,0,0,0,0,100,0),
(@path,8,-3574.0989,-1917.8884,94.641045,0,0,0,0,100,0),
(@path,9,-3543.6143,-1922.9417,93.78076,0,0,0,0,100,0),
(@path,10,-3514.391,-1891.8881,96.05839,0,0,0,0,100,0),
(@path,11,-3482.7354,-1879.4718,95.54532,0,0,0,0,100,0),
(@path,12,-3447.3694,-1879.2826,94.04059,0,0,0,0,100,0),
(@path,13,-3419.4883,-1883.6552,93.07612,0,0,0,0,100,0),
(@path,14,-3401.6602,-1915.7799,93.66566,0,0,0,0,100,0),
(@path,15,-3377.1729,-1946.9575,91.91544,0,0,0,0,100,0),
(@path,16,-3359.4075,-1987.9889,93.354164,0,0,0,0,100,0),
(@path,17,-3351.847,-2020.0239,93.34684,0,0,0,0,100,0),
(@path,18,-3347.3481,-2061.3584,96.55564,0,0,0,0,100,0),
(@path,19,-3337.5916,-2084.593,91.86515,0,0,0,0,100,0),
(@path,20,-3305.2717,-2097.2861,91.791664,0,0,0,0,100,0),
(@path,21,-3264.5898,-2110.5752,93.58816,0,0,0,0,100,0),
(@path,22,-3221.6958,-2091.54,92.918495,0,0,0,0,100,0),
(@path,23,-3175.735,-2081.8813,91.791664,0,0,0,0,100,0),
(@path,24,-3131.3293,-2093.495,91.81647,0,0,0,0,100,0),
(@path,25,-3093.5208,-2117.2578,93.19572,0,0,0,0,100,0),
(@path,26,-3050.1245,-2119.8708,93.09464,0,0,0,0,100,0),
(@path,27,-3005.5127,-2109.9685,92.291664,0,0,0,0,100,0),
(@path,28,-2967.4277,-2095.7334,91.791664,0,0,0,0,100,0),
(@path,29,-2936.955,-2117.254,91.791664,0,0,0,0,100,0),
(@path,30,-2908.1777,-2144.7766,93.2714,0,0,0,0,100,0),
(@path,31,-2871.219,-2160.007,92.05509,0,0,0,0,100,0),
(@path,32,-2853.049,-2161.5356,91.791664,0,0,0,0,100,0),
(@path,33,-2835.0942,-2182.703,95.2443,0,0,0,0,100,0),
(@path,34,-2795.9773,-2209.954,95.784584,0,0,0,0,100,0),
(@path,35,-2758.5547,-2238.7458,92.954506,0,0,0,0,100,0),
(@path,36,-2721.4429,-2257.816,91.791664,0,0,0,0,100,0),
(@path,37,-2681.0037,-2258.5547,91.95255,0,0,0,0,100,0),
(@path,38,-2673.5525,-2282.2383,91.791664,0,0,0,0,100,0),
(@path,39,-2647.4885,-2312.194,92.01603,0,0,0,0,100,0),
(@path,40,-2624.1008,-2319.0713,92.736,0,0,0,0,100,0),
(@path,41,-2583.4438,-2317.825,91.791664,0,0,0,0,100,0),
(@path,42,-2553.0298,-2291.6404,93.56666,0,0,0,0,100,0),
(@path,43,-2522.4128,-2288.3354,95.39027,0,0,0,0,100,0),
(@path,44,-2480.3079,-2292.0088,94.91757,0,0,0,0,100,0),
(@path,45,-2440.1282,-2314.39,94.61803,0,0,0,0,100,0),
(@path,46,-2414.875,-2342.5525,91.83561,0,0,0,0,100,0),
(@path,47,-2396.1902,-2380.3955,91.791664,0,0,0,0,100,0),
(@path,48,-2380.417,-2413.0195,92.82902,0,0,0,0,100,0),
(@path,49,-2353.339,-2423.769,95.19796,0,0,0,0,100,0),
(@path,50,-2310.5186,-2422.7778,95.587776,0,0,0,0,100,0),
(@path,51,-2293.4502,-2402.058,93.38322,0,0,0,0,100,0),
(@path,52,-2295.2888,-2370.951,92.66499,0,0,0,0,100,0),
(@path,53,-2286.9407,-2341.9426,93.4555,0,0,0,0,100,0),
(@path,54,-2252.9795,-2320.2158,93.7934,0,0,0,0,100,0),
(@path,55,-2207.6965,-2319.8152,93.1684,0,0,0,0,100,0),
(@path,56,-2185.574,-2344.3398,94.98741,0,0,0,0,100,0),
(@path,57,-2207.6965,-2319.8152,93.1684,0,0,0,0,100,0),
(@path,58,-2252.9795,-2320.2158,93.7934,0,0,0,0,100,0),
(@path,59,-2286.9407,-2341.9426,93.4555,0,0,0,0,100,0),
(@path,60,-2295.2888,-2370.951,92.66499,0,0,0,0,100,0),
(@path,61,-2293.4502,-2402.058,93.38322,0,0,0,0,100,0),
(@path,62,-2310.5186,-2422.7778,95.587776,0,0,0,0,100,0),
(@path,63,-2353.339,-2423.769,95.19796,0,0,0,0,100,0),
(@path,64,-2380.417,-2413.0195,92.82902,0,0,0,0,100,0),
(@path,65,-2396.1902,-2380.3955,91.791664,0,0,0,0,100,0),
(@path,66,-2414.875,-2342.5525,91.83561,0,0,0,0,100,0),
(@path,67,-2440.1282,-2314.39,94.61803,0,0,0,0,100,0),
(@path,68,-2480.3079,-2292.0088,94.91757,0,0,0,0,100,0),
(@path,69,-2522.4128,-2288.3354,95.39027,0,0,0,0,100,0),
(@path,70,-2553.0298,-2291.6404,93.56666,0,0,0,0,100,0),
(@path,71,-2583.4438,-2317.825,91.791664,0,0,0,0,100,0),
(@path,72,-2624.1008,-2319.0713,92.736,0,0,0,0,100,0),
(@path,73,-2647.4885,-2312.194,92.01603,0,0,0,0,100,0),
(@path,74,-2673.5525,-2282.2383,91.791664,0,0,0,0,100,0),
(@path,75,-2681.0037,-2258.5547,91.95255,0,0,0,0,100,0),
(@path,76,-2721.4429,-2257.816,91.791664,0,0,0,0,100,0),
(@path,77,-2758.5547,-2238.7458,92.954506,0,0,0,0,100,0),
(@path,78,-2795.9773,-2209.954,95.784584,0,0,0,0,100,0),
(@path,79,-2835.0942,-2182.703,95.2443,0,0,0,0,100,0),
(@path,80,-2853.049,-2161.5356,91.791664,0,0,0,0,100,0),
(@path,81,-2871.219,-2160.007,92.05509,0,0,0,0,100,0),
(@path,82,-2908.1777,-2144.7766,93.2714,0,0,0,0,100,0),
(@path,83,-2936.955,-2117.254,91.791664,0,0,0,0,100,0),
(@path,84,-2967.4277,-2095.7334,91.791664,0,0,0,0,100,0),
(@path,85,-3005.5127,-2109.9685,92.291664,0,0,0,0,100,0),
(@path,86,-3050.1245,-2119.8708,93.09464,0,0,0,0,100,0),
(@path,87,-3093.5208,-2117.2578,93.19572,0,0,0,0,100,0),
(@path,88,-3131.3293,-2093.495,91.81647,0,0,0,0,100,0),
(@path,89,-3175.735,-2081.8813,91.791664,0,0,0,0,100,0),
(@path,90,-3221.6958,-2091.54,92.918495,0,0,0,0,100,0),
(@path,91,-3264.5898,-2110.5752,93.58816,0,0,0,0,100,0),
(@path,92,-3305.2717,-2097.2861,91.791664,0,0,0,0,100,0),
(@path,93,-3337.5916,-2084.593,91.86515,0,0,0,0,100,0),
(@path,94,-3347.3481,-2061.3584,96.55564,0,0,0,0,100,0),
(@path,95,-3351.847,-2020.0239,93.34684,0,0,0,0,100,0),
(@path,96,-3359.4075,-1987.9889,93.354164,0,0,0,0,100,0),
(@path,97,-3377.1729,-1946.9575,91.91544,0,0,0,0,100,0),
(@path,98,-3401.6602,-1915.7799,93.66566,0,0,0,0,100,0),
(@path,99,-3419.4883,-1883.6552,93.07612,0,0,0,0,100,0),
(@path,100,-3447.3694,-1879.2826,94.04059,0,0,0,0,100,0),
(@path,101,-3482.7354,-1879.4718,95.54532,0,0,0,0,100,0),
(@path,102,-3514.391,-1891.8881,96.05839,0,0,0,0,100,0),
(@path,103,-3543.6143,-1922.9417,93.78076,0,0,0,0,100,0),
(@path,104,-3574.0989,-1917.8884,94.641045,0,0,0,0,100,0),
(@path,105,-3604.3447,-1934.8683,93.6461,0,0,0,0,100,0),
(@path,106,-3633.491,-1962.7506,91.96043,0,0,0,0,100,0),
(@path,107,-3674.7666,-1972.0784,92.34276,0,0,0,0,100,0),
(@path,108,-3718.9587,-1949.9241,94.24338,0,0,0,0,100,0),
(@path,109,-3743.7683,-1944.3379,93.25019,0,0,0,0,100,0),
(@path,110,-3765.317,-1912.2642,92.659584,0,0,0,0,100,0),
(@path,111,-3780.6667,-1879.9966,94.51902,0,0,0,0,100,0),
(@path,112,-3802.9849,-1847.3167,94.4449,0,0,0,0,100,0);
-- 0x204CB0002003294000001C00001E1E9F .go xyz -3780.6667 -1879.9966 94.51902

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (45809, 45813, 45817);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(45809, 45809, 0, 0, 512, 0, 0), -- Leader
(45809, 45810, 5, 190, 512, 0, 0), -- A
(45809, 45811, 5, 170, 512, 0, 0), -- B
(45809, 45812, 6, 180, 512, 0, 0), -- C
(45813, 45813, 0, 0, 512, 0, 0), -- Leader
(45813, 45814, 5, 190, 512, 0, 0), -- A
(45813, 45815, 5, 170, 512, 0, 0), -- B
(45813, 45816, 6, 180, 512, 0, 0), -- C
(45817, 45817, 0, 0, 512, 0, 0), -- Leader
(45817, 45818, 5, 170, 512, 0, 0), -- A
(45817, 45819, 5, 190, 512, 0, 0), -- B
(45817, 45820, 6, 180, 512, 0, 0); -- C
