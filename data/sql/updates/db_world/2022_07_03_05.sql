-- DB update 2022_07_03_04 -> 2022_07_03_05
--
SET @NPC_HEBJIN := 28636;
SET @NPC_BAT := 28639;
SET @GO_DRUM := 190695;

DELETE FROM `creature` WHERE `guid` IN (117079,117301);

UPDATE `creature_template` SET `speed_run`=0.857143, `unit_flags`=33024, `AIName`='SmartAI' WHERE `entry`=@NPC_HEBJIN;
UPDATE `creature_template` SET `speed_run`=2, `unit_flags`=256, `AIName`='SmartAI' WHERE `entry`=@NPC_BAT;

DELETE FROM `event_scripts` WHERE `id`=18773;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(18773,0,10,@NPC_HEBJIN,180000,0,5988.715,-3878.036,417.1502,2.356194);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO_DRUM;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NPC_HEBJIN,@NPC_BAT) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO_DRUM AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NPC_HEBJIN*100,@NPC_BAT*100) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC_HEBJIN,0,0,0,54,0,100,0,0,0,0,0,80,@NPC_HEBJIN*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - Just summoned - Run script'),
(@NPC_HEBJIN,0,1,2,38,0,100,0,0,1,0,0,11,52354,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin - On data 0 1 set - Spellcast Script Effect - Creature Attack GUID from Dot Variable'),
(@NPC_HEBJIN,0,2,3,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - On data 0 1 set - Set Home Pos'),
(@NPC_HEBJIN,0,3,4,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,5937.22,-3820.871,366.5563,0, 'Heb''Jin - On data 0 1 set - Move to position'),
(@NPC_HEBJIN,0,4,5,61,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - On data 0 1 set - Say line'),
(@NPC_HEBJIN,0,5,6,61,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - On data 0 1 set - Remove unit_flags IMMUNE_TO_PC'),
(@NPC_HEBJIN,0,6,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin - On data 0 1 set - Start attack'),
(@NPC_HEBJIN,0,7,0,0,0,100,0,1000,1000,7000,8000,11,12734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - On update IC - Spellcast Ground Smash'),
(@NPC_HEBJIN,0,8,0,0,0,100,0,5000,5000,10000,12000,11,15548,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin - On update IC - Spellcast Thunder Clap'),
(@NPC_HEBJIN,0,9,0,13,0,100,0,12000,15000,0,0,11,12555,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Heb''Jin - On target casting - Spellcast Pummel'),

(@NPC_BAT,0,0,1,11,0,100,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spawn - Remove unit_field_bytes1 (dead)'),
(@NPC_BAT,0,1,2,61,0,100,0,0,0,0,0,11,52353,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spawn - Spellcast Script Effect - Creature Capture GUID to Dot Variable'),
(@NPC_BAT,0,2,0,61,0,100,0,0,0,0,0,4,10892,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spawn - Play sound'),
(@NPC_BAT,0,3,0,27,0,100,1,0,0,0,0,53,1,@NPC_BAT,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On passenger boarded - Start WP movement'),
(@NPC_BAT,0,4,5,40,0,100,0,4,@NPC_BAT,0,0,28,43671,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On WP 4 reached - Remove aura Ride Vehicle'),
(@NPC_BAT,0,5,6,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@NPC_HEBJIN,10,0,0,0,0,0, 'Heb''Jin''s Bat - On WP 4 reached - Set data 0 1 Heb''Jin'),
(@NPC_BAT,0,6,0,61,0,100,0,0,0,0,0,80,@NPC_BAT*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On WP 4 reached - Run script'),
(@NPC_BAT,0,7,8,8,0,100,0,52151,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spellhit Bat Net - Set unit_flags IMMUNE_TO_PC'),
(@NPC_BAT,0,8,9,61,0,100,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spellhit Bat Net - Set unit_field_bytes1 (dead)'),
(@NPC_BAT,0,9,0,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat - On spellhit Bat Net - Despawn after 5 seconds'),

(@GO_DRUM,1,0,1,70,0,100,0,2,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Heb''Jin''s Drum - On state changed - Store targetlist'),
(@GO_DRUM,1,1,0,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,@NPC_HEBJIN,100,0,0,0,0,0, 'Heb''Jin''s Drum - On state changed - Send targetlist to Heb''Jin'),

(@NPC_HEBJIN*100,9,0,0,0,0,100,0,0,0,0,0,11,52353,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin script - Spellcast Script Effect - Creature Capture GUID to Dot Variable'),
(@NPC_HEBJIN*100,9,1,0,0,0,100,0,3200,3200,0,0,11,52154,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin script - Spellcast Taunt'),
(@NPC_HEBJIN*100,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin script - Say line'),
(@NPC_HEBJIN*100,9,3,0,0,0,100,0,300,300,0,0,12,@NPC_BAT,8,0,0,0,0,8,0,0,0,5984.547,-3882.621,417.4379,1.919862, 'Heb''Jin script - Summon Heb''Jin''s Bat'),
(@NPC_HEBJIN*100,9,4,0,0,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,@NPC_BAT,10,0,0,0,0,0, 'Heb''Jin script - Send targetlist'),
(@NPC_HEBJIN*100,9,5,0,0,0,100,0,5700,5700,0,0,1,1,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin script - Say line'),
(@NPC_HEBJIN*100,9,6,0,0,0,100,0,2400,2400,0,0,11,43671,0,0,0,0,0,19,@NPC_BAT,10,0,0,0,0,0, 'Heb''Jin script - Spellcast Ride Vehicle'),

(@NPC_BAT*100,9,0,0,0,0,100,0,2000,2000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Heb''Jin''s Bat script 1 - Remove unit_flags IMMUNE_TO_PC'),
(@NPC_BAT*100,9,1,0,0,0,100,0,0,0,0,0,49,0,0,0,0,0,0,12,1,0,0,0,0,0,0, 'Heb''Jin''s Bat script 1 - Start attack');

DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid`=190695;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=19069500;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(190695, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On state changed - Store targetlist'),
(190695, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19069500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - Linked with Previous Event - Run Script'),
(19069500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 98562, 23837, 0, 0, 0,0,0, 'Heb\'Jin\'s Drum - Script - Set Data ELM General Purpose Bunny'),
(19069500, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28636, 100, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - Script - Send Target list to heb jin');

UPDATE `smart_scripts` SET `action_param2`=2, `action_param3`=300000 WHERE  `entryorguid`=2863600 AND `source_type`=9 AND `id`=3 AND `link`=0;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=28636 AND `id`=9;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=28639 AND `id`=10;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28636, 0, 9, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb Jin - On Evade - Despawn'),
(28639, 0, 10, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb Jins Bat - On Evade - Despawn');

DELETE FROM `event_scripts` WHERE `id`=18773;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=-98562;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-98562, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny - On Data Set - Set Data'),
(-98562, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 28636, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 5988.71, -3878.04, 417.15, 2.35619, 'ELM General Purpose Bunny - Linked with Previous Event - Spawn Heb Jin');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceId`=0 AND `SourceEntry`=-98562;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -98562, 0, 0, 29, 1, 28636, 200, 0, 1, 0, 0, '', 'Only run SAI if no heb jin nearby'),
(22, 1, -98562, 0, 0, 29, 1, 28639, 200, 0, 1, 0, 0, '', 'Only run SAI if no heb jins bat nearby');
