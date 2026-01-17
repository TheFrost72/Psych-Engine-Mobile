#!/bin/bash
set -e

# Set haxelib repository folder
HAXELIB_DIR="$HOME/haxelib"

# Tell haxelib to use this folder
echo "$HAXELIB_DIR" > "$HOME/.haxelib"
mkdir -p "$HAXELIB_DIR"

echo "Installing the libraries"
haxelib install hxcpp 4.3.2 --skip-dependencies --quiet
haxelib install lime 8.2.2 --skip-dependencies --quiet
haxelib install openfl 9.4.1 --skip-dependencies --quiet
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
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis --skip-dependencies --quiet
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git --skip-dependencies --quiet

# Install extension-androidtools manually (CI-safe)
EXT_DIR="$HAXELIB_DIR/extension-androidtools"
rm -rf "$EXT_DIR"
git clone --depth 1 https://github.com/TheFrost72/extension-androidtools "$EXT_DIR"
echo "$EXT_DIR" > "$EXT_DIR/.current"

echo "Libraries installed successfully"
