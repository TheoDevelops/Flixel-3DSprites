package;

import flixel.FlxG;
import flixel.FlxSprite3D;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var sprite:FlxSprite3D;

	override public function create()
	{
		super.create();

		sprite = new FlxSprite3D();
		sprite.loadGraphic('assets/images/cat.png');
		sprite.setGraphicSize(200, 200);
		sprite.updateHitbox();
		sprite.screenCenter();
		add(sprite);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
