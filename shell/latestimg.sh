cat << description
Copy latest screenshot from PC to destination folder.
description

read -rp "Destination dir: " dir 

cd ~/Pictures/Screenshots
newest=$(ls -Art | tail -n 1)
cp "$newest" "$dir" || echo "No directory found."; exit 1;