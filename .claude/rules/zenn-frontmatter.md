---
paths:
  - "articles/**"
---

# Zenn 記事の規約（articles/）

`articles/` は Zenn 記事（編集対象・source of truth）。

## ファイル名

- 慣習は `YYYY-MM-DD-tech.md`。
- slug（`npx zenn new:article --slug` で指定する値）は `a-z0-9` とハイフン/アンダースコア、12〜50 文字。

## フロントマター（Zenn 形式）

- `title` — 記事タイトル
- `emoji` — 1 文字の絵文字（Zenn のアイキャッチ用。記事本文中の絵文字禁止とは別枠）
- `type` — `tech` または `idea`
- `topics` — 配列
- `published` — `true` / `false`

Qiita 側（`qiita/public/*.md`）はフロントマター形式が異なり、同期処理が相互変換する。
Qiita 形式: `title` / `tags` / `private` / `updated_at` / `id` / `organization_url_name` / `slide` / `ignorePublish`。
Qiita ファイルは自動生成物のため手動編集しない（[[qiita-generated]] を参照）。
