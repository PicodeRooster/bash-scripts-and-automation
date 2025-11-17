read -rp "Enter file path: " dir
cd "$dir" || { echo "Directory not found"; exit 1; }

echo '<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="">
    </head>
    <body>
        <script src="" async defer></script>
    </body>
</html>' > index.html

default_name=$(basename "$PWD")
read -rp "Project name [${default_name}]: " projectname
projectname=${projectname:-$default_name}

mkdir js
mkdir css
touch js/main.js
touch css/main.css

mkdir media
cd media

mkdir videos
mkdir sfx
mkdir images