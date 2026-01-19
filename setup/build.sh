#!/bin/bash
set -e

echo "Installing the libraries"
haxelib install hxcpp 4.3.2 --skip-dependencies --quiet
haxelib install lime 8.1.2 --skip-dependencies --quiet
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

haxelib git hxluajit https://github.com/MAJigsaw77/hxluajit --skip-dependencies --quiet
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git --skip-dependencies --quiet
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate --skip-dependencies --quiet
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90 --skip-dependencies --quiet
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git --quiet
haxelib git extension-androidtools https://github.com/Neuro-Engine-Team/extension-androidtools --skip-dependencies --quiet

echo "Libraries installed successfully"
