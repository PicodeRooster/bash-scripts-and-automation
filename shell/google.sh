url="https://www.google.com/search?q="
if [ $# = 0 ]; then
  echo "Please pass at least one search term as an argument."
else
  for arg in "$@"; do
    open "$url$arg"
    done
fi