#!/bin/bash
# 用法：./extract-nccl-env.sh  [目录]  [输出文件]
ROOT=${1:-.}                    # 默认扫描当前目录
OUT=${2:-nccl-env-list.txt}     # 默认输出文件名

# 递归扫描所有常见源码文件
grep -r -h -E 'ncclGetEnv\s*\(\s*"([^"]+)"\s*\)' \
  --include="*.cc" --include="*.cpp" --include="*.c" --include="*.h" "$ROOT" |
sed -E 's/.*ncclGetEnv\s*\(\s*"([^"]+)"\s*\).*/\1/' |
sort -u > "$OUT"

echo "=== NCCL 环境变量列表（去重）==="
cat "$OUT"
echo "共 $(wc -l < "$OUT") 个变量，已保存到 $OUT"
