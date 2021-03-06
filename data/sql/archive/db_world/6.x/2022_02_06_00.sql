-- DB update 2022_02_04_13 -> 2022_02_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_13 2022_02_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643393372625004300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643393372625004300');

DELETE FROM `creature` WHERE `guid` = 247519;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 20 WHERE `id1` = 14361;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_06_00' WHERE sql_rev = '1643393372625004300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
