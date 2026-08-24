---
name: cleanup-merged
description: マージ済みの作業ブランチをリモート・ローカルから削除し、main を最新化する。PR マージ後の後片付けに使う。
---

# マージ済みブランチの掃除

GitHub Flow の手順 6-7(マージ後のブランチ削除と main 最新化)を実行する。

## 手順

1. **PR のマージを確認する**

   GitHub MCP の `pull_request_read`(method: `get`)で `merged: true` を確認する。
   マージされていなければ、ここで止めてユーザーに報告する。

2. **main を最新化する**

   ```bash
   git checkout main && git pull --rebase origin main
   ```

   このリポジトリのローカル `main` には upstream が設定されていないため、
   引数なしの `git pull --rebase` は "no tracking information" で失敗する。
   `origin main` を明示すること。

3. **Qiita 同期の取り込みを確認する**

   マージした変更に `articles/` が含まれる場合、GitHub Actions が
   `🔄 auto: ...` コミットを main に積む。手順 2 の pull で取り込めていなければ
   1 分ほど待って再度 pull する(詳細は CLAUDE.md)。

4. **削除候補を列挙する**

   ```bash
   git branch --merged main | grep -v main          # ローカル
   git branch -r --merged main | grep -v main       # リモート
   ```

   Rebase and merge / Squash merge でマージされたブランチは SHA が変わるため
   `--merged` や `git branch -d` では検出できない。その場合は `git cherry` で
   内容が同等かを判定する(全行が `-` なら main に取り込み済み)。

   ```bash
   git cherry main <branch>   # + で始まる行が無ければ削除してよい
   ```

5. **削除する**

   ```bash
   git push origin --delete <branch>...
   git branch -D <branch>...
   ```

   ローカルの一括削除は次のスクリプトでも行える。upstream が `[gone]` かつ
   `git cherry` で取り込み済みと確認できたブランチだけを削除する。

   ```bash
   .claude/scripts/prune-merged-branches.sh
   ```

6. `git branch -a` と `git log --oneline -3` で結果を報告する。

## 注意

- main は絶対に削除しない
- マージ済みと確認できないブランチは削除せず、ユーザーに報告する
- upstream を持たないローカル専用ブランチ(push したことがないもの)は
  マージ判定ができないため対象外。ユーザーに存在を報告するだけにとどめる
