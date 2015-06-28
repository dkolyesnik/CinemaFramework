package examples.shooter.episodes;
import cinema.Episode;
import cinema.Hunter;
import examples.shooter.roles.PositionRole;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class FollowMouseEpisode extends Episode
{
	public var hunter:Hunter;
	
	public var mouseHunter:Hunter;
	
	private var _objects:Array<PositionRole> = [];
	
	private var _mouseArray:Array<PositionRole> = [];
	
	private var _mouseX:Float;
	private var _mouseY:Float;
	
	public function new() 
	{
		super();
	}
	
	override public function update(dt:Float):Void 
	{
		if (_mouseArray.length == 0)
			return;
		
		for (obj in _objects) {
			obj.x = _mouseArray[0].x;
			obj.y = _mouseArray[0].y;
		}
	}
	
	override function _setupHunters():Void 
	{
		hunter = _createHunter(PositionRole, _objects);
		hunter.filter.noTags(["system"]);
		mouseHunter = _createHunter(PositionRole, _mouseArray);
		mouseHunter.filter.actorName("mouse");
	}
	
}