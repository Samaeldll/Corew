-- DB update 2022_06_16_04 -> 2022_06_16_05
--
DELETE FROM `game_event_gameobject` WHERE `guid`=28704;
INSERT INTO `game_event_gameobject` VALUES
(27,28704),
(28,28704),
(29,28704),
(30,28704);

UPDATE `gameobject_template` SET `ScriptName`='go_brazier_of_madness' WHERE `entry`=180327;
