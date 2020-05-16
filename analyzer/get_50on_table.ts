import 'console.table';
import { tryConnection, query } from './dbutils';
const moji = require('moji');

const SUFFIX = process.argv[2];

const PREFIX_TABLE = `あいうえお
かきくけこ
さしすせそ
たちつてと
なにぬねの
はひふへほ
まみむめも
や　ゆ　よ
らりるれろ
わ　を　ん`;

const main = async () => {
  const connection = await tryConnection();

  const query_result = await query(
    `select
      *
      from words
      where kana like "_${SUFFIX}"`,
    connection
  );
  const query_result_array = Array.from(query_result) as {
    kana: string;
    word: string;
  }[];

  console.log('50 on table:', SUFFIX);

  let table = [[], [], [], [], []];
  Array.from(PREFIX_TABLE.replace(/\n/g, ''))
    .map((prefix) => {
      if (prefix === '　') return '';
      const prefix_kana = moji(prefix).convert('HG', 'KK').toString();
      const current_query_result = query_result_array.find(
        (x) => x.kana[0] === prefix_kana
      );
      const current_word = current_query_result
        ? current_query_result.word
        : '';
      return `${prefix}: ${current_word}`;
    })
    .forEach((x, i) => {
      table[i % 5].push(x);
    });
  table = table.map((x) => x.reverse());
  console.table(table);

  connection.end();
};
main();
