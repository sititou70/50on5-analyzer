# 50 on 5 analyzer

ラーメンズの「[50 on 5](https://www.youtube.com/watch?v=LdCEXnF8TmQ)」に登場する，「すべて同じ文字を使った 50 音表」を探索します．

## 依存

- Docker
- Node.js(v12.16.3〜)
- iconv CLI
- Bash
- git

## 使い方

### `./get_suffix_ranking.sh [suffix length]`

後ろに付きやすい文字のランキングを表示します．

例：`./get_suffix_ranking.sh 2`

### `./get_50on_table.sh [suffix]`

後ろに`suffix`をつけて 50 音表を作成します．

例：`./get_50on_table.sh ンコ`

### `./clean.sh`

いろいろ消してきれいにします

## Licence

MIT
