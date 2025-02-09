package;

import flixel.FlxCamera3D;
import flixel.FlxG;
import flixel.FlxSprite3D;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSort;
import openfl.geom.Vector3D;

class PlayState extends FlxState
{
	var sprite3DGroup:FlxTypedGroup<FlxSprite3D>;
	var camera3D:FlxCamera3D;

	override public function create()
	{
		super.create();

		camera3D = new FlxCamera3D();
		camera3D.bgColor = 0xFF72E9E9;
		FlxG.cameras.add(camera3D, false);

		sprite3DGroup = new FlxTypedGroup<FlxSprite3D>();

		for (i in 0...3 * 3)
		{
			var sprite = new FlxSprite3D();
			sprite.loadGraphic('assets/images/cat.png');
			sprite.setGraphicSize(150, 150);
			sprite.updateHitbox();
			sprite.screenCenter();
			sprite.cameras = [camera3D];

			sprite.x -= -200 + 200 * (i % 3);
			sprite.z -= 500 * Math.floor(i / 3);
			sprite3DGroup.add(sprite);

			sprite.alpha = 0.5;
		}

		add(sprite3DGroup);
	}

	override public function update(elapsed:Float)
	{
		var rotationSpeed = 50 * elapsed;

		sprite3DGroup.sort((_, a, b) ->
		{
			return Math.round(a.z - b.z);
		});

		camera3D.yaw = (FlxG.mouse.screenX - FlxG.width / 2) * rotationSpeed * 0.001;
		camera3D.pitch = (FlxG.mouse.screenY - FlxG.height / 2) * rotationSpeed * 0.001;

		// MOVE CODE
		var mult = 200 * elapsed;
		if (FlxG.keys.pressed.W)
			camera3D.moveForward(-1 * mult);
		if (FlxG.keys.pressed.S)
			camera3D.moveForward(1 * mult);

		if (FlxG.keys.pressed.SHIFT)
			camera3D.moveUp(1 * mult);
		if (FlxG.keys.pressed.SPACE)
			camera3D.moveUp(-1 * mult);
		if (FlxG.keys.pressed.A)
			camera3D.moveRight(-1 * mult);
		if (FlxG.keys.pressed.D)
			camera3D.moveRight(1 * mult);

		super.update(elapsed);
	}
}
