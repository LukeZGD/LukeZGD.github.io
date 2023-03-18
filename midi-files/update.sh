#!/bin/bash
echo '<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>LukeZGD MIDI Files</title>
        <link rel="stylesheet" href="../style.css">
    </head>
    <body>
        <div align="center">
        <h1>LukeZGD MIDI Files</h1>
        <p>Please give credit to me when used.</p>
        <hr/>' > index.html
for f in midis/*; do
    echo "${f:6}"
    echo "<p><a href=\"$f\">${f:6}</a></p>" >> index.html
done
echo '</div>
    </body>
</html>' >> index.html
