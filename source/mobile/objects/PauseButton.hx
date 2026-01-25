package mobile.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import states.PlayState;

class PauseButton extends FlxGroup
{
	var staticSpr:FlxSprite;
	var animSpr:FlxSprite;
	var isPausing:Bool = false;
	var cam:FlxCamera;

	public function new(camHUD:FlxCamera)
	{
		super();
		cam = camHUD;

		staticSpr = new FlxSprite();
		staticSpr.loadGraphic(Paths.image("pauseCircle"));
		staticSpr.cameras = [cam];
		staticSpr.scale.set(0.8, 0.8);
		staticSpr.x = FlxG.width - staticSpr.width + 34;
		staticSpr.y = -32;
		staticSpr.alpha = 0.2;
		add(staticSpr);

		animSpr = new FlxSprite();
		animSpr.frames = Paths.getSparrowAtlas("pauseButton");
		animSpr.animation.addByPrefix("pause", "pause", 24, false);
		animSpr.animation.pause();
		animSpr.cameras = [cam];
		animSpr.x = FlxG.width - animSpr.width - 23;
		animSpr.y = 20;
		animSpr.scale.set(0.75, 0.75);
		add(animSpr);
	}

	public function updateButton(elapsed:Float)
	{
		if (isPausing) return;

		if (FlxG.mouse.justPressed && animSpr.overlapsPoint(FlxG.mouse.getWorldPosition(cam)))
		{
			isPausing = true;
			animSpr.animation.play("pause", true);

			FlxTween.tween(staticSpr, {alpha: 0}, 0.5);
			FlxTween.tween(animSpr, {alpha: 0}, 0.5, {
				onComplete: function(_)
				{
					var fn = Reflect.field(PlayState.instance, "openPauseMenu");
					if (fn != null) Reflect.callMethod(PlayState.instance, fn, []);
				}
			});
		}
	}

	public function onResume()
	{
		isPausing = false;
		staticSpr.alpha = 0;
		animSpr.alpha = 0;

		FlxTween.tween(staticSpr, {alpha: 0.2}, 0.15);
		FlxTween.tween(animSpr, {alpha: 1}, 0.15);
	}
}
