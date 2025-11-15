read -rp "Enter file path: " dir
cd "$dir" || { echo "Directory not found"; exit 1; }

default_name=$(basename "$PWD")
read -rp "GitHub repo name [${default_name}]: " reponame
reponame=${reponame:-$default_name}

read -rp "Visibility (public/private) [public]: " vis
vis=${vis:-public}

git init -b main 2>/dev/null || git init
git branch -M main

git add .
git commit -m "Initial commit"

gh repo create "$reponame" \
  --"$vis" \
  --source=. \
  --remote=origin \
  --push