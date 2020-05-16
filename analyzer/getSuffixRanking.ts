import { tryConnection, query } from './dbutils';
import 'console.table';

const TABLE_LIMIT = 100;
const SUFFIX_LENGTH = parseInt(process.argv[2]);

const main = async () => {
  const connection = await tryConnection();

  const query_result = await query(
    `select
      SUBSTRING(kana, 2) as suffix,
      count(*) as count
      from words
      where CHAR_LENGTH(kana) = ${SUFFIX_LENGTH + 1}
      group by suffix
      order by count desc
      limit ${TABLE_LIMIT}`,
    connection
  );

  console.table(query_result);

  connection.end();
};
main();
