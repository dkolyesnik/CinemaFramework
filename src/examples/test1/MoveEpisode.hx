package examples.test1;
import cinema.Hunter;
import cinema.Role;
import cinema.Episode;
import cinema.Story;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoveEpisode extends Episode
{
	public var moveableHunter:Hunter<MoverRole>;
	
	public function new() 
	{
		super();
		
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new MoverRole());
	}
	
	override function _createHunters() 
	{
		moveableHunter = new Hunter<MoverRole>(MoverRole.NAME);
	}
	
	override function _addHunters() 
	{
		_hunters.push(cast moveableHunter);
	}
	
	override public function update(dt:Float):Void 
	{
		for (moveable in moveableHunter) {
			moveable.x += Std.int(Math.random() * 4 - 2);
			moveable.y += Std.int(Math.random() * 4 - 2);
		}
	}
}