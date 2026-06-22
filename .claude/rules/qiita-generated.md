---
paths:
  - "qiita/**"
---

# Qiita 記事ファイルの取り扱い

`qiita/public/` 配下のファイルは **自動生成物**。原則として手動編集しない。

- 正（source of truth）は Zenn 記事（`articles/*.md`）。Qiita 記事はそこから変換生成される。
- `main`/`master` への push をトリガーに、GitHub Actions（`.github/workflows/publish.yml`）が
  [zenn-qiita-sync](https://github.com/C-Naoki/zenn-qiita-sync) を実行して Zenn 記事から変換・Qiita へ公開する。
- 手で編集しても次回同期で上書きされる可能性がある。内容を変えたい場合は `articles/` 側を編集する。
- 同期処理が管理するフロントマターのフィールドは手動で書き換えない:
  `id` / `updated_at` / `organization_url_name` など。
- 自動コミットは `🔄 auto: ...` というメッセージで作られる（Actions 由来）。
