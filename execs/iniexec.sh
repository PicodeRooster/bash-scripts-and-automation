cat << description
call this with the name of the new file you wish to create
type ./iniexec.sh <your file name>
description

file_name="$1"
ext=".sh"
new_file="$file_name$ext"
echo "echo \"Hello from new file.\"" > "$new_file"
chmod +x $new_file
nano $new_file
