#!/bin/bash
set -e

cd ..
echo "Makking the main haxelib and setuping folder in same time.."
mkdir ~/haxelib && haxelib setup ~/haxelib
echo "Installing dependencies..."
echo "This might take a few moments depending on your internet speed."
haxelib install hxcpp 4.3.2 --skip-dependencies --quiet
haxelib git lime https://github.com/Neuro-Engine-Team/lime --skip-dependencies --quiet
haxelib install openfl 9.3.3 --skip-dependencies --quiet
haxelib install flixel 5.6.1 --skip-dependencies --quiet
haxelib install flixel-addons 3.2.2 --skip-dependencies --quiet
haxelib install flixel-tools 1.5.1 --skip-dependencies --quiet

haxelib install tjson 1.4.0 --skip-dependencies --quiet
haxelib install format 3.7.0 --skip-dependencies --quiet
haxelib install hxp 1.3.0 --skip-dependencies --quiet
haxelib install hxvlc 2.0.1 --skip-dependencies --quiet
haxelib install hxdiscord_rpc 1.2.4 --skip-dependencies --quiet
haxelib install hxcpp-debug-server 1.2.4 --skip-dependencies --quiet
haxelib install hscript-iris 1.1.3 --skip-dependencies --quiet
haxelib install SScript 8.1.6 --skip-dependencies --quiet

haxelib git linc_luajit https://github.com/Neuro-Engine-Team/linc_luajit --skip-dependencies --quiet
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e --quiet --skip-dependencies
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90 --quiet --skip-dependencies
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666 --quiet
haxelib git extension-androidtools https://github.com/Neuro-Engine-Team/extension-androidtools --skip-dependencies --quiet

echo "Libraries installed successfully"
