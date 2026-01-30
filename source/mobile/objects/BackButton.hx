package mobile.objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class BackButton extends FlxSprite
{
    public function new()
    {
        super();

        var uiScale:Float = Math.min(
            FlxG.width / 720,
            FlxG.height / 1280
        );

        frames = Paths.getSparrowAtlas('backButton');
        antialiasing = true;

        x = FlxG.width * 0.84;
        y = FlxG.height * 0.69;

        centerOrigin();
        scale.set(uiScale * 1.25, uiScale * 1.25);

        animation.addByIndices('idle', 'back', [0], '', 24, false);
        animation.addByIndices('hold', 'back', [5], '', 24, false);
        animation.addByIndices(
            'confirm',
            'back',
            [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],
            '',
            24,
            false
        );

        animation.play('idle');
        scrollFactor.set(0,0);

        updateHitbox();
        centerOffsets();
    }
}
