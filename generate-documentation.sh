#!/bin/sh

# Create html header
cat <<'EOF' > handbook.html
<!DOCTYPE html>
<html lang='pt-br'>
<head>
    <title>Handbook Poison GNU/Linux ☠️</title>
    <meta charset='UTF-8'>
    <meta name="description" content="Poison linux">
    <meta name="keywords" content="handbook, handbook poison, documentacao">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { margin: 0 auto; max-width: 75%; font-size: 1.2em; font-family: sans-serif; }
        pre { background-color: black; color: white; tab-size: 4; padding: 1%; overflow-x: auto; }
    </style>
</head>
<body>
EOF

# Generate handbook
markdown handbook.md > handbook2.html

# Send to handbook.html
cat handbook2.html >> handbook.html

# Footer
cat << EOF >> handbook.html
</body>
</html>
EOF

rm handbook2.html
