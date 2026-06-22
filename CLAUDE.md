# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## このリポジトリの役割

ZennとQiitaに公開する技術記事を管理するアーカイブリポジトリ。コードのビルド対象ではなく、Markdownコンテンツが中心。

## アーキテクチャ / 同期の仕組み（最重要）

- **Zenn記事が正（source of truth）**。`articles/` のMarkdownを編集する。
- **`qiita/public/` のファイルは自動生成物**。`main`/`master` への push をトリガーに、GitHub Actions（`.github/workflows/publish.yml`）が [zenn-qiita-sync](https://github.com/C-Naoki/zenn-qiita-sync) を実行して Zenn記事から変換・Qiitaへ公開する。
- 自動コミットは `🔄 auto: ...` というメッセージで作られる（Actions由来）。
- パスごとの詳細な制約はパススコープルールに分離している（該当パスのファイルを扱うとき自動で読み込まれる）:
  - Qiita 記事の取り扱い → `.claude/rules/qiita-generated.md`（`qiita/**`）
  - Zenn 記事のファイル名・フロントマター規約 → `.claude/rules/zenn-frontmatter.md`（`articles/**`）

## Git運用（push 後の pull）

- `main` への push 後は、GitHub Actions による Qiita 同期（`🔄 auto: ...` コミット）が完了してから取り込む必要がある。同期完了前に pull すると自動生成コミットを取り込めない。
- この「push → 約1分待機 → `git pull --rebase origin main`」の流れは `.claude/settings.json` の PostToolUse フックで**自動化済み**。手動での待機・pull は不要。

## 主なコマンド

```bash
# プレビューサーバ起動（http://localhost:8000）
npx zenn preview

# 新規記事の作成
npx zenn new:article --slug 記事のスラッグ --title タイトル --type idea --emoji ✨
#   --slug: a-z0-9 とハイフン/アンダースコア、12〜50文字
#   --type: tech | idea
```

注意: `package.json` の `test` スクリプトはプレースホルダ（`exit 1`）であり、テストは存在しない。

## ディレクトリ

- `articles/` — Zenn記事（編集対象）。ファイル名は `YYYY-MM-DD-tech.md` の慣習。
- `qiita/public/` — Qiita記事（自動生成、原則手動編集しない）。
- `books/` — Zenn books（Zennのbook構成に従う）。
- `images/` — 記事で使う画像。`images/YYYY-MM-DD/` のように日付ごとに配置。

## 補足

- `tsconfig.json` は `scripts/ztoq.tsx` を `include` しているが、現状そのファイル/`scripts` ディレクトリは存在しない（変換処理は外部Actionに移行済み）。
