---
name: new-article
description: Zenn の新規記事を規約どおりに作成する。slug・type・emoji・ファイル名・フロントマターを検証しながら npx zenn new:article を実行し雛形を整える。技術記事を新しく書き始めるときに使う。
---

# 新規記事の作成（Zenn）

Zenn 記事（`articles/`、source of truth）を規約に沿って新規作成するための手順。

## 手順

1. **記事メタ情報の確認**
   ユーザーから以下を確認する（不足していれば AskUserQuestion で尋ねる）:
   - タイトル
   - `type`: `tech` か `idea`
   - `emoji`: アイキャッチ用の絵文字 1 文字（記事本文中の絵文字とは別枠で、Zenn では必須）
   - `topics`: タグ（配列）

2. **slug の決定と検証**
   - 形式: `a-z0-9` とハイフン/アンダースコアのみ、12〜50 文字。
   - ファイル名の慣習に合わせ、`YYYY-MM-DD-tech` のような日付プレフィックスを推奨（日付は当日）。

3. **記事の生成**
   ```bash
   npx zenn new:article --slug <slug> --title "<タイトル>" --type <tech|idea> --emoji <絵文字>
   ```
   生成物は `articles/<slug>.md`。

4. **フロントマターの仕上げ**
   生成された `articles/<slug>.md` のフロントマターを確認・補完する:
   - `title` / `emoji` / `type` / `topics`(配列) / `published`
   - 公開前は `published: false` のままにし、ユーザーの指示で `true` にする。
   - 詳細な規約は `.claude/rules/zenn-frontmatter.md`（`articles/**` で自動ロード）に従う。

5. **プレビュー（任意）**
   ```bash
   npx zenn preview   # http://localhost:8000
   ```

## 注意

- Qiita 記事（`qiita/public/`）は push 後の GitHub Actions で自動生成される。手動で作成・編集しない。
- 公開は `main` への push がトリガー。push 後の同期 pull は PostToolUse フックで自動化済み。
