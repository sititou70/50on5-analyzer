
USE dict;

CREATE TABLE words (
  kana varchar(128) NOT NULL
) engine=innodb default charset=utf8;

LOAD DATA
  INFILE "/docker-entrypoint-initdb.d/TEMP_word.list"
  INTO TABLE dict.words
    FIELDS
      TERMINATED BY ','
      ENCLOSED BY '"';
