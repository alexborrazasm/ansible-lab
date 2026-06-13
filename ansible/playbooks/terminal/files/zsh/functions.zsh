# Remove spaces from file and directory names, replacing them with underscores.
nospace() {
  find "${1:-.}" -depth -name "* *" -print0 | while IFS= read -r -d "" f; do
    local dir=$(dirname "$f")
    local base=$(basename "$f")

    local new_base=$(echo "$base" | sed -e 's/[[:space:]]/_/g' -e 's/_\+/_/g' -e 's/^_//' -e 's/_$//')

    if [[ "$base" != "$new_base" && -n "$new_base" ]]; then
      if [[ ! -e "$dir/$new_base" ]]; then
        mv -v "$f" "$dir/$new_base"
      else
        echo "Skipping: $new_base already exists in $dir"
      fi
    fi
  done
}
