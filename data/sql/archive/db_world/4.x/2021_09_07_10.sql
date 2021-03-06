-- DB update 2021_09_07_09 -> 2021_09_07_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_07_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_07_09 2021_09_07_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630853983117888200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630853983117888200');

DELETE FROM 
	`gameobject_loot_template` 
WHERE 
	`Entry` = 1619 # Armor crate
AND 
	`Item` 
IN 
	# Potions
	(929,
	3385,
	# Food/Drinks
	1205,
	4538,
	5504,
	# Scrolls
	1478,
	1711,
	1712,
	2290,
	# Bags
	1725,
	# Cloth
	4306,
	# Herbs
	2453, 
	# Ores
	2771,
	# Green items
	865,
	1529,
	1705,
	3041,
	3042,
	3185,
	3186,
	4346,
	5007,
	5214,
	6045,
	7449,
	7450,
	10424,
	11970,
	13037,
	14168,
	14178,
	14180,
	14183,
	14190,
	14196,
	14197,
	14198,
	14199,
	14201,
	14205,
	14209,
	14210,
	14397,
	14399,
	14403,
	14406,
	14579,
	14587,
	14753,
	14758,
	15129,
	15133,
	15136,
	15148,
	15231,
	15232,
	15250,
	15346,
	15354,
	15518,
	15524,
	15531,
	15534,
	15539,
	15544,
	15549,
	15559,
	15568,
	15892);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_10' WHERE sql_rev = '1630853983117888200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
