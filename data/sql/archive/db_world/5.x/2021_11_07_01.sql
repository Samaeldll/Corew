-- DB update 2021_11_07_00 -> 2021_11_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_07_00 2021_11_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636026426526412472'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636026426526412472');

-- Removes Sayge's Fortunes from all NPCs
DELETE FROM `creature_loot_template` WHERE `Comment` LIKE '%Sayge\'s Fortune%' AND `Item` IN (19229, 19237, 19238, 19239, 19240, 19241, 19242, 19243, 19244, 19245, 19246, 19247, 19248, 19249, 19250, 19251, 19252, 19253, 19254, 19255, 19256, 19266, 19423, 19424, 19443, 19451, 19452, 19453, 19454);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_07_01' WHERE sql_rev = '1636026426526412472';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
