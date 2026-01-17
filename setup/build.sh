#!/bin/bash
set -e

echo "Installing the libraries..."

haxelib install openfl 9.4.1 --quiet
haxelib install flixel 5.6.1 --quiet
haxelib install flixel-addons 3.2.2 --quiet
haxelib install flixel-tools 1.5.1 --quiet
haxelib install tjson 1.4.0 --quiet
haxelib install hxcpp 4.3.2 --quiet
haxelib install hxvlc 2.0.1 --quiet
haxelib install hxdiscord_rpc 1.2.4 --quiet
haxelib install hxcpp-debug-server 1.2.4 --quiet
haxelib install hscript-iris 1.1.3 --quiet
haxelib install SScript 8.1.6 --quiet
haxelib install format 3.7.0 --quiet
haxelib install hxp 1.3.0 --quiet

haxelib git lime https://github.com/TheFrost72/lime --quiet
haxelib git hxluajit https://github.com/MAJigsaw77/hxluajit --quiet
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git --quiet
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate --quiet
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis --quiet
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git --quiet

echo "Libraries installed successfully"
