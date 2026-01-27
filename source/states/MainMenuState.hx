package states;

import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

enum MainMenuColumn {
	LEFT;
	CENTER;
	RIGHT;
}

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.0.4';
	public static var curSelected:Int = 0;
	public static var neuroEngineVersion:String = '0.1.0';
	public static var curColumn:MainMenuColumn = CENTER;
	var allowMouse:Bool = true;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var leftOption:Array<String>;
	var leftItems:FlxTypedGroup<FlxSprite>;
	var leftSelected:Int = 0;
	var rightOption:String;
	var rightItem:FlxSprite;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods', #end
		'credits'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	static var showOutdatedWarning:Bool = true;
	override function create()
	{
		super.create();
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end
		persistentUpdate = persistentDraw = true;

		var yScroll:Float = 0.25;
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		var scale = Math.max(FlxG.width / bg.width, FlxG.height / bg.height);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set();
		bg.scale.set(scale, scale);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		var scaleM = Math.max(FlxG.width / magenta.width, FlxG.height / magenta.height);
		magenta.scrollFactor.set(0, yScroll);
		magenta.updateHitbox();
		magenta.scale.set(scaleM, scaleM);
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var uiScale:Float = Math.min(FlxG.width / 1280, FlxG.height / 720);
		for (num => option in optionShit)
		{
			var item:FlxSprite = createMenuItem(option, 0, ((num * 160) + 90) * scaleY);
			item.y += (4 - optionShit.length) * 70 * scaleY;
			item.scale.set(uiScale, uiScale);
			item.screenCenter(X);
			item.x -= 23 * uiScale;
			item.y -= 16 * uiScale;
			if (option == 'story_mode')
			{
				item.x -= 6 * uiScale;
			}
			item.updateHitbox();
		}

		leftItems = new FlxTypedGroup<FlxSprite>();
		add(leftItems);

		leftOption = [
			#if ACHIEVEMENTS_ALLOWED 'achievements' #else null #end,
			'options'
		];

		for (i in 0...leftOption.length)
		{
			var lopt = leftOption[i];
			if (lopt == null) continue;
			var litem = createMenuItem(lopt, 60, 490 + (i * 80));
			leftItems.add(litem);
		}

		var neuroVer:FlxText = new FlxText(12, FlxG.height - 64, 0, "Neuro Engine v" + neuroEngineVersion, 12);
		neuroVer.scrollFactor.set();
		neuroVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(neuroVer);
		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');
		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		#if CHECK_FOR_UPDATES
		if (showOutdatedWarning && ClientPrefs.data.checkForUpdates && substates.OutdatedSubState.updateVersion != psychEngineVersion) {
			persistentUpdate = false;
			showOutdatedWarning = false;
			openSubState(new substates.OutdatedSubState());
		}
		#end

		FlxG.camera.follow(camFollow, null, 0.15);
		addTouchPad('NONE', 'E');
	}

	function createMenuItem(name:String, x:Float, y:Float):FlxSprite
	{
		var menuItem:FlxSprite = new FlxSprite(x, y);
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_$name');
		menuItem.animation.addByPrefix('idle', '$name idle', 24, true);
		menuItem.animation.addByPrefix('selected', '$name selected', 24, true);
		menuItem.animation.play('idle');
		menuItem.updateHitbox();
		menuItem.antialiasing = ClientPrefs.data.antialiasing;
		menuItem.scrollFactor.set();
		menuItems.add(menuItem);
		return menuItem;
	}

	var selectedSomethin:Bool = false;
	var timeNotMoving:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				if (curColumn == CENTER) changeItem(-1);
				else if (curColumn == LEFT && leftItems.members.length > 0) leftSelected = FlxMath.wrap(leftSelected - 1, 0, leftItems.members.length - 1);
			}
			if (controls.UI_DOWN_P)
			{
				if (curColumn == CENTER) changeItem(1);
				else if (curColumn == LEFT && leftItems.members.length > 0) leftSelected = FlxMath.wrap(leftSelected + 1, 0, leftItems.members.length - 1);
			}

			var allowMouseLocal:Bool = allowMouse;
			if (allowMouseLocal && ((FlxG.mouse.deltaScreenX != 0 && FlxG.mouse.deltaScreenY != 0) || FlxG.mouse.justPressed))
			{
				allowMouseLocal = false;
				FlxG.mouse.visible = true;
				timeNotMoving = 0;

				var selectedItem:FlxSprite = null;
				if (curColumn == CENTER) selectedItem = menuItems.members[curSelected];
				else if (curColumn == LEFT && leftItems.members.length > 0) selectedItem = leftItems.members[leftSelected];

				var foundLeftOverlap:Bool = false;
				for (j in 0...leftItems.members.length)
				{
					var lm:FlxSprite = leftItems.members[j];
					if (FlxG.mouse.overlaps(lm))
					{
						allowMouseLocal = true;
						foundLeftOverlap = true;
						if (selectedItem != lm)
						{
							curColumn = LEFT;
							leftSelected = j;
							changeItem();
						}
						break;
					}
				}

				if (!foundLeftOverlap)
				{
					var dist:Float = -1;
					var distItem:Int = -1;
					for (i in 0...optionShit.length)
					{
						var memb:FlxSprite = menuItems.members[i];
						if (FlxG.mouse.overlaps(memb))
						{
							var distance:Float = Math.sqrt(Math.pow(memb.getGraphicMidpoint().x - FlxG.mouse.screenX, 2) + Math.pow(memb.getGraphicMidpoint().y - FlxG.mouse.screenY, 2));
							if (dist < 0 || distance < dist)
							{
								dist = distance;
								distItem = i;
								allowMouseLocal = true;
							}
						}
					}
					if (distItem != -1)
					{
						if (selectedItem != menuItems.members[distItem])
						{
							curColumn = CENTER;
							curSelected = distItem;
							changeItem();
						}
					}
				}
			}
			else
			{
				timeNotMoving += elapsed;
				if(timeNotMoving > 2) FlxG.mouse.visible = false;
			}

			switch(curColumn)
			{
				case CENTER:
					if(controls.UI_LEFT_P && leftItems.members.length > 0)
					{
						curColumn = LEFT;
						changeItem();
					}
					else if(controls.UI_RIGHT_P && rightOption != null)
					{
						curColumn = RIGHT;
						changeItem();
					}
				case LEFT:
					if(controls.UI_RIGHT_P)
					{
						curColumn = CENTER;
						changeItem();
					}
				case RIGHT:
					if(controls.UI_LEFT_P)
					{
						curColumn = CENTER;
						changeItem();
					}
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT || (FlxG.mouse.overlaps(menuItems, FlxG.camera) && FlxG.mouse.justPressed && allowMouseLocal))
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				selectedSomethin = true;
				FlxG.mouse.visible = false;

				if (ClientPrefs.data.flashing)
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				var item:FlxSprite = null;
				var option:String = null;
				switch(curColumn)
				{
					case CENTER:
						option = optionShit[curSelected];
						item = menuItems.members[curSelected];
					case LEFT:
						if (leftItems.members.length > 0)
						{
							option = leftOption[leftSelected];
							item = leftItems.members[leftSelected];
						}
					case RIGHT:
						option = rightOption;
						item = rightItem;
				}

				if (item == null) selectedSomethin = false;
				else
				{
					FlxFlicker.flicker(item, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (option)
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());
							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end
							#if ACHIEVEMENTS_ALLOWED
							case 'achievements':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end
							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
							case 'donate':
								CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
								selectedSomethin = false;
								item.visible = true;
							default:
								trace('Menu Item ${option} doesn\'t do anything');
								selectedSomethin = false;
								item.visible = true;
						}
					});
					for (memb in menuItems)
					{
						if(memb == item)
							continue;
						FlxTween.tween(memb, {alpha: 0}, 0.4, {ease: FlxEase.quadOut});
					}
				}
			}
			else if (controls.justPressed('debug_1') || touchPad.buttonE.justPressed)
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}
		super.update(elapsed);
	}

	function changeItem(change:Int = 0)
	{
		if(change != 0) curColumn = CENTER;
		curSelected = FlxMath.wrap(curSelected + change, 0, optionShit.length - 1);
		FlxG.sound.play(Paths.sound('scrollMenu'));

		for (item in menuItems)
		{
			item.animation.play('idle');
			item.centerOffsets();
		}

		var selectedItem:FlxSprite = null;
		if (curColumn == CENTER)
		{
			selectedItem = menuItems.members[curSelected];
		}
		else if (curColumn == LEFT && leftItems.members.length > 0)
		{
			if (leftSelected >= leftItems.members.length) leftSelected = 0;
			selectedItem = leftItems.members[leftSelected];
		}
		else if (curColumn == RIGHT)
		{
			selectedItem = rightItem;
		}
		if (selectedItem != null)
		{
			selectedItem.animation.play('selected');
			selectedItem.centerOffsets();
			camFollow.y = selectedItem.getGraphicMidpoint().y;
		}
	}
}
