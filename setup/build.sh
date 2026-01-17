#!/bin/bash
set -e

echo"Installing the libraries..."

# Haxe libs (haxelib)
haxelib install openfl 9.4.1
haxelib install flixel 5.6.1
haxelib install flixel-addons 3.2.2
haxelib install flixel-tools 1.5.1
haxelib install tjson 1.4.0
haxelib install hxcpp 4.3.2
haxelib install hxvlc 2.0.1
haxelib install hxdiscord_rpc 1.2.4
haxelib install hxcpp-debug-server 1.2.4
haxelib install hscript-iris 1.1.3
haxelib install SScript 8.1.6
haxelib install format 3.7.0
haxelib install hxp 1.3.0

# Git libs (haxelib git)
haxelib git lime https://github.com/TheFrost72/lime
haxelib git hxluajit https://github.com/MAJigsaw77/hxluajit
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git

echo"libraries installed successfully"
