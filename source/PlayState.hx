package;

import flixel.FlxG;
import flixel.FlxSprite3D;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var sprite:FlxSprite3D;
	var spriten:FlxSprite;

	override public function create()
	{
		super.create();

		sprite = new FlxSprite3D();
		sprite.loadGraphic('assets/images/cat.png');
		sprite.setGraphicSize(200, 200);
		sprite.updateHitbox();
		sprite.screenCenter();
		add(sprite);
		spriten = new FlxSprite();
		spriten.loadGraphic('assets/images/cat.png');
		spriten.setGraphicSize(200, 200);
		spriten.updateHitbox();
		spriten.screenCenter();
		add(spriten);

		sprite.alpha = spriten.alpha = 0.5;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
