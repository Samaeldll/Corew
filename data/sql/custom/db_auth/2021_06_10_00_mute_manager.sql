ALTER TABLE `account_muted`
CHANGE COLUMN `guid` `accountid` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier' FIRST,
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `active` TINYINT NOT NULL AFTER `mutereason`,
MODIFY COLUMN `mutedate` BIGINT UNSIGNED NOT NULL DEFAULT 0 AFTER `accountid`,
MODIFY COLUMN `mutetime` INT NOT NULL DEFAULT 0 AFTER `mutedate`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`) USING BTREE;

ALTER TABLE `account`
DROP COLUMN `mutetime`,
DROP COLUMN `mutereason`,
DROP COLUMN `muteby`;
