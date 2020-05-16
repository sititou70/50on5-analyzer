import * as mysql from 'mysql';
import { Connection } from 'mysql';
import 'console.table';

const TABLE_LIMIT = 100;
const WORDS_LENGTH = parseInt(process.env.WORDS_LENGTH);

const sleep = async (ms: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, ms));

const connect = async (connection: Connection): Promise<Connection> =>
  new Promise((resolve, reject) => {
    connection.connect((e) => (e ? reject(e) : resolve(connection)));
  });

const query = async (query: string, connention: Connection): Promise<any> =>
  new Promise((resolve, reject) => {
    connention.query(query, (e, result) => (e ? reject(e) : resolve(result)));
  });

const main = async () => {
  let connection: Connection;

  while (true) {
    let res: Connection;
    try {
      res = await connect(
        mysql.createConnection({
          host: 'localhost',
          user: process.env.MYSQL_USER,
          password: process.env.MYSQL_PASSWD,
          database: 'dict',
        })
      );
    } catch (e) {
      console.log(e.code, 'retrying...');
      await sleep(1500);
      continue;
    }
    connection = res;
    break;
  }

  const query_result = await query(
    `select
      SUBSTRING(kana, 2) as suffix,
      count(*) as count
      from words
      where CHAR_LENGTH(kana) = ${WORDS_LENGTH}
      group by suffix
      order by count desc`,
    connection
  );

  console.table(Array.from(query_result).slice(0, TABLE_LIMIT));

  connection.end();
};
main();
