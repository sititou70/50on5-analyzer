
USE dict;

CREATE TABLE words (
  word varchar(64) NOT NULL,
  kana varchar(64) NOT NULL
) engine=innodb default charset=utf8;

LOAD DATA
  INFILE "/docker-entrypoint-initdb.d/TEMP_word.list"
  INTO TABLE dict.words
    FIELDS
      TERMINATED BY '\t';
