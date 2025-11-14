#if !macro
//Discord API
#if DISCORD_ALLOWED
import backend.Discord;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if ACHIEVEMENTS_ALLOWED
import backend.Achievements;
#end

// Mobile Controls
import mobile.objects.MobileControls;
import mobile.objects.IMobileControls;
import mobile.objects.Hitbox;
import mobile.objects.TouchPad;
import mobile.objects.TouchButton;
import mobile.input.MobileInputID;
import mobile.backend.MobileData;
import mobile.input.MobileInputManager;
import mobile.backend.TouchUtil;

// Android
#if android
// Core Android tools
import extension.androidtools.Tools;
import extension.androidtools.Permissions;
import extension.androidtools.Settings;

// Callback
import extension.androidtools.callback.Callback;

// Content
import extension.androidtools.content.Context;

// JNI
import extension.androidtools.jni.JNICache;
import extension.androidtools.jni.JNIUtil;

// Media
import extension.androidtools.media.AudioManager;

// OS
import extension.androidtools.os.Build;
import extension.androidtools.os.Environment;

// Widget
import extension.androidtools.widget.Toast;
#end


#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import backend.Paths;
import backend.Controls;
import backend.CoolUtil;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.CustomFadeTransition;
import backend.ClientPrefs;
import backend.Conductor;
import backend.BaseStage;
import backend.Difficulty;
import backend.Mods;
import backend.Language;
import mobile.backend.StorageUtil;

import backend.ui.*; //Psych-UI

import objects.Alphabet;
import objects.BGSprite;

import states.PlayState;
import states.LoadingState;

#if flxanimate
import flxanimate.*;
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

//Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxDestroyUtil;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import shaders.flixel.system.FlxShader;

using StringTools;
#end
