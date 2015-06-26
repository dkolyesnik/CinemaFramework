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
	public var moveableHunter:Hunter;
	
	private var _movebleObjects:Array<MoverRole> = [];
	
	public function new() 
	{
		super();
		
	}
	
	override function _setupHunters():Void 
	{
		moveableHunter = _createHunter(MoverRole, _movebleObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		for (moveable in _movebleObjects) {
			moveable.x += Std.int(Math.random() * 4 - 2);
			moveable.y += Std.int(Math.random() * 4 - 2);
		}
	}
}