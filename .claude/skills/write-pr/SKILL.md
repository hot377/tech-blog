---
name: write-pr
description: Pull Request を規約どおりに作成・修正する。.github/pull_request_template.md の構成に沿って本文の先頭に Closes を書き、確認事項は該当セクションだけを残して根拠付きで埋める。作業ブランチを push して PR を出すとき、既存 PR の本文を直すときに使う。
---

# Pull Request の作成・修正

GitHub Flow の手順 4-5（作業ブランチの push と PR 作成）を実行する。
ブランチ運用の基本は CLAUDE.md に従う。

Issue 側の規約は `write-issue` スキルに揃えてある。マージ後の後片付けは `cleanup-merged`。

対象リポジトリは `hot377/tech-blog`。

## 手順

1. **ブランチと変更内容を確認する**

   ```bash
   git branch --show-current
   git log --oneline main..HEAD
   git diff main...HEAD --stat
   ```

   `main` にいる場合はここで止める。**main へ直接コミット・push しない。**

2. **記事の変更を含む場合はレビューを通す**

   `articles/` に変更がある場合、PR を出す前に `article-reviewer` エージェントでレビューするかを
   ユーザーに確認し、了承を得てから実行する。指摘を反映してから手順3へ進む。

3. **テンプレートを読む**

   ```bash
   cat .github/pull_request_template.md
   ```

   **本文の構成はテンプレートが唯一の情報源。** 案内用の HTML コメントは、埋めたら削除する。

4. **先頭に Closes を書く**

   関連する Issue がある場合、**本文の1行目**に `Closes #N` を書く（概要の文中や末尾に混ぜない）。
   関連 Issue が無い場合は、`Closes` の行ごと削除する。

5. **概要と内容を書く**

   内容には、差分を見れば分かること（ファイル一覧、行数）を書かない。

   | 種類 | 書くこと |
   | --- | --- |
   | 記事 | 記事で扱ったテーマを箇条書きで |
   | 設定・仕組みの変更 | 何がどう変わるか、なぜその方式にしたか |

   Issue の内容から意図的に変えた点があれば、理由とあわせて明記する
   （例: 「Issue の『切り分け方』は本文で扱えていないため『実際に返るエラーメッセージ』に調整した」）。

6. **確認事項を埋める**

   - **該当しないセクションは見出しごと削除する**（記事 PR なら「設定・仕組みを変更した場合」を消す）
   - 確認できた項目は `- [x]` にし、**その下にネストで根拠を1行書く**。チェックだけ付けて終わらせない

     ```markdown
     - [x] 個人情報・機密情報が含まれていないか（...）
       - 画像内の ARN とアカウントIDはぼかし済み。ロール名は検証用のみ
     ```

   - 未確認の項目は `- [ ]` のまま残し、何が未確認かを本文に書く

7. **push する**

   push は外部への公開にあたるため、**実行前に AskUserQuestion で確認を取る。**

   ```bash
   git push -u origin <branch>
   ```

8. **PR を作成する**

   ```
   mcp__github__create_pull_request (title, head, base: main, body)
   ```

   タイトルは英語の Conventional Commits 形式（コミットメッセージと同じ規約）。

   例: `docs: add article on IAM managed policy quota increase to 20`

9. **ラベルを付ける**

   `create_pull_request` に `labels` パラメータは無い。**作成後に別途付ける。**

   ```
   mcp__github__issue_write (method: update, issue_number: <PR番号>, labels: [...])
   ```

   ラベルの選び方と存在確認は `write-issue` の手順5と同じ。紐づく Issue があれば同じラベルを付ける。

10. **修正する場合**

    `pull_request_read`(method: `get`)で現在の本文を取得してから
    `mcp__github__update_pull_request` で更新する。更新後は、何をどう変えたかを報告する。

## 注意

- 本文に絵文字を使わない
- **PR 本文に Claude Code のセッション URL や生成署名（`Generated with Claude Code` など）を入れない**
- コミットメッセージに `Co-Authored-By` などの署名を含めない
- 記事 PR をマージすると、`published: true` の記事は Zenn に公開され、
  GitHub Actions による Qiita 同期（`auto:` で始まる自動コミット）が走る。
  マージ前にこの影響をユーザーと確認する
