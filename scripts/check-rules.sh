#!/usr/bin/env bash
# Fails when a kit rule or shared skill would not load as designed:
# - a Cursor rule (.cursor/rules/*.mdc) without frontmatter, alwaysApply or description
# - a rule whose Cursor body differs from its neutral copy (.agents/rules/*.md), or has no counterpart
# - a shared skill hidden from the model (disable-model-invocation: true)
# Usage: scripts/check-rules.sh [kit-root]   (default: repo containing this script)

set -u

root="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
cursor_dir="$root/.cursor/rules"
neutral_dir="$root/.agents/rules"
skills_dir="$root/.agents/skills"
shared_skills="ask-git-project ask-agent-knowledge ask-agent-skill-discipline"

errors=0
fail() { echo "FAIL: $*"; errors=$((errors + 1)); }

frontmatter() { awk 'NR == 1 && $0 != "---" { exit } NR > 1 && $0 == "---" { exit } NR > 1 { print }' "$1"; }
body() {
  awk 'NR == 1 && $0 == "---" { fm = 1; next } fm && $0 == "---" { fm = 0; next } !fm { print }' "$1" |
    sed '/./,$!d'
}

for dir in "$cursor_dir" "$neutral_dir" "$skills_dir"; do
  [ -d "$dir" ] || { echo "FAIL: missing directory $dir"; exit 1; }
done

for mdc in "$cursor_dir"/*.mdc; do
  name="$(basename "$mdc" .mdc)"
  fm="$(frontmatter "$mdc")"
  if [ "$(head -n 1 "$mdc")" != "---" ] || [ -z "$fm" ]; then
    fail "$name: Cursor rule has no frontmatter (Cursor treats it as manual and never loads it)"
  else
    echo "$fm" | grep -Eq '^alwaysApply: (true|false)[[:space:]]*$' ||
      fail "$name: frontmatter needs alwaysApply: true|false"
    echo "$fm" | grep -Eq '^description: [^[:space:]]' ||
      fail "$name: frontmatter needs a description"
    echo "$fm" | grep -E '^description: ' | grep -Ev '^description: ["'"'"']' | grep -q ': .*: ' &&
      fail "$name: unquoted ': ' in description (invalid YAML; quote it or drop the colon)"
  fi

  neutral="$neutral_dir/$name.md"
  if [ ! -f "$neutral" ]; then
    fail "$name: no neutral copy at .agents/rules/$name.md"
  elif ! diff -q <(body "$mdc") <(body "$neutral") > /dev/null; then
    fail "$name: body differs between .cursor/rules/$name.mdc and .agents/rules/$name.md"
  fi
done

for md in "$neutral_dir"/*.md; do
  name="$(basename "$md" .md)"
  [ -f "$cursor_dir/$name.mdc" ] || fail "$name: no Cursor copy at .cursor/rules/$name.mdc"
done

for skill in $shared_skills; do
  file="$skills_dir/$skill/SKILL.md"
  if [ ! -f "$file" ]; then
    fail "$skill: shared skill missing"
  elif frontmatter "$file" | grep -Eq '^disable-model-invocation: true'; then
    fail "$skill: shared skill hidden from the model (disable-model-invocation: true)"
  fi
done

if [ "$errors" -gt 0 ]; then
  echo "$errors problem(s) found"
  exit 1
fi
echo "OK: rules and shared skills load as designed"
