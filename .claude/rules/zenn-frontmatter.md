---
paths:
  - "articles/**"
---

# Zenn 記事の規約（articles/）

`articles/` は Zenn 記事（編集対象・source of truth）。

## ファイル名

- 形式は `YYYY-MM-DD-<内容を表す英語 slug>.md`（例: `2026-11-18-cndw2026-report.md`）。日付は執筆開始日。
- slug（`npx zenn new:article --slug` で指定する値、拡張子を除くファイル名）は `a-z0-9` とハイフン/アンダースコア、12〜50 文字。日付部分で 11 文字使うため、内容部分は 39 文字以内に収める。
- 2026-10-13 以前の記事は旧形式の `YYYY-MM-DD-tech.md` のまま。Zenn ではファイル名が記事 URL になるため、公開済み記事はリネームしない。

## フロントマター（Zenn 形式）

- `title` — 記事タイトル
- `emoji` — 1 文字の絵文字（Zenn のアイキャッチ用。記事本文中の絵文字禁止とは別枠）
- `type` — `tech` または `idea`
- `topics` — 配列
- `published` — `true` / `false`

Qiita 側（`qiita/public/*.md`）はフロントマター形式が異なり、同期処理が相互変換する。
Qiita 形式: `title` / `tags` / `private` / `updated_at` / `id` / `organization_url_name` / `slide` / `ignorePublish`。
Qiita ファイルは自動生成物のため手動編集しない（[[qiita-generated]] を参照）。
