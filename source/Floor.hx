package;

import flixel.FlxCamera3D;
import flixel.FlxG;
import flixel.FlxSprite3D;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSort;
import openfl.geom.Vector3D;

class Floor extends FlxState
{
	var sprite3DGroup:FlxTypedGroup<FlxSprite3D>;
	var camera3D:FlxCamera3D;

    var wall:FlxSprite3D;
    var floor:FlxSprite3D;

	override public function create()
	{
		super.create();

		camera3D = new FlxCamera3D();
		camera3D.bgColor = 0xFF535353;
		FlxG.cameras.add(camera3D, false);

		sprite3DGroup = new FlxTypedGroup<FlxSprite3D>();

        var cellSize = 32;
        
        var gridPixels = FlxGridOverlay.createGrid(cellSize, cellSize, cellSize * 8, cellSize * 10, true, 0xFFFFFFFF, 0xFF000000);
        floor = new FlxSprite3D();
        floor.loadGraphic(gridPixels);
        floor.updateHitbox();
        floor.screenCenter();
        floor.cameras = [camera3D];
        sprite3DGroup.add(floor);

        wall = new FlxSprite3D();
        wall.makeGraphic(Math.round(floor.width), Math.round(floor.width), 0xFF000000);
        wall.updateHitbox();
        wall.screenCenter();
        wall.cameras = [camera3D];
        sprite3DGroup.add(wall);

        floor.angle3D.x = -90;
        floor.y += floor.height * .5 - 32;
        wall.z -= floor.height * .5;

		add(sprite3DGroup);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		sprite3DGroup.sort((_, a, b) ->
		{
			return Math.round(a.z - b.z);
		});

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

		// ANGLE MOVE CODE
		if (FlxG.keys.pressed.RIGHT)
			camera3D.yaw += elapsed;
		if (FlxG.keys.pressed.LEFT)
			camera3D.yaw -= elapsed;
		if (FlxG.keys.pressed.UP)
			camera3D.pitch += elapsed;
		if (FlxG.keys.pressed.DOWN)
			camera3D.pitch -= elapsed;
		if (FlxG.keys.pressed.Z)
			camera3D.roll += elapsed;
		if (FlxG.keys.pressed.X)
			camera3D.roll -= elapsed;
	}
}
