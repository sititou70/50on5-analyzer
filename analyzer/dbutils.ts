import * as mysql from 'mysql';
import { Connection } from 'mysql';

export const sleep = async (ms: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, ms));

export const connect = async (connection: Connection): Promise<Connection> =>
  new Promise((resolve, reject) => {
    connection.connect((e) => (e ? reject(e) : resolve(connection)));
  });

export const tryConnection = async (): Promise<Connection> => {
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

  return connection;
};

export const query = async (
  query: string,
  connention: Connection
): Promise<any> =>
  new Promise((resolve, reject) => {
    connention.query(query, (e, result) => (e ? reject(e) : resolve(result)));
  });
