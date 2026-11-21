---
title: "PCを捨てる前に cipher /w を使ってみた"
emoji: "🧹"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["windows", "ctf", "writeup", "コマンドプロンプト"]
published: true
---

## はじめに

ずっと放置していた Windows PC を、ついに捨てました！！
復元されると困るデータがあるけど、消去ソフトにお金はかけたくない。そんなときに見つけたのが cipher コマンドです。

https://www.youtube.com/watch?v=TxXGpRvKckw&t=607s

## この記事で学べること

- cipher コマンドって何？（実は暗号化のコマンドです）
- `cipher /w` で空き領域を上書きすると、どれくらい時間がかかるのか
- お金をかけずに PC のデータを消す流れ

## 想定読者

- PC を捨てたいけど、データが残るのが心配な人
- できればタダで済ませたい人

## cipher コマンドとは

cipher は、Windows に最初から入っているコマンドです。
本来はファイルやフォルダを暗号化（EFS）するためのものですが、`/w` オプションを付けると、ドライブの空き領域を上書きしてくれます。

ポイントは「空き領域だけ」を上書きするところ。使っているファイルは消えないので、先に PC を初期化しておきましょう！

## PC の初期化

YouTube の動画のとおりに進めて、1 時間程度でできました！

https://www.youtube.com/watch?v=pVcwKfyALy8

## cipher /w の実行

いざ、cipher コマンドを実行！！！！！

```cmd
cipher /w:C:\
```

40 分くらいかかりました！！
事前にデータ削除したけど、空き領域が少なかった。。？

## 削除した PC のスペック

| 項目 | 内容 |
| --- | --- |
| プロセッサ | Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz(1.99GHz) |
| RAM | 8.00GB |
| ストレージ | 256GB |
| OS | Windows 11 |

## まとめ

cipher コマンド便利だなぁ。。
実行時間が長いので、コマンド実行して放置しておこう！！

## 参考資料

- [cipher | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows-server/administration/windows-commands/cipher)
