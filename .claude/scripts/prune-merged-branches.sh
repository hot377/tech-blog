#!/usr/bin/env bash
# PR マージ後に不要になったローカルブランチを削除する。
#
# 削除対象は次の両方を満たすブランチのみ:
#   1. upstream が削除済み ([gone]) — GitHub 側でマージ後にブランチが消えている
#   2. 全コミットが main に取り込み済み (git cherry で + 行が無い)
#
# 2 の判定に git cherry を使うのは、squash/rebase マージで SHA が変わると
# git branch -d が「未マージ」と誤判定するため。内容が同等なら削除してよい。
# upstream を持たないローカル専用ブランチは 1 で除外されるので消えない。
set -uo pipefail

DIR="${CLAUDE_PROJECT_DIR:-.}"
cd "$DIR" 2>/dev/null || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

git fetch --prune --quiet origin 2>/dev/null || exit 0

CURRENT=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
DELETED=""

while read -r branch track; do
  [ "${track:-}" = "[gone]" ] || continue
  [ "$branch" = "main" ] && continue
  [ "$branch" = "$CURRENT" ] && continue
  git cherry main "$branch" 2>/dev/null | grep -q '^+' && continue
  git branch -D "$branch" >/dev/null 2>&1 && DELETED="$DELETED $branch"
done < <(git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads)

if [ -n "$DELETED" ]; then
  printf '{"systemMessage":"マージ済みのローカルブランチを削除しました:%s"}\n' "$DELETED"
fi
exit 0
