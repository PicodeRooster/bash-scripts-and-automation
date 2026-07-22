query="$1"
url="http://www.google.com/search?q=${query// /+}" 
xdg-open "$url" >/dev/null 2>&1 & disown