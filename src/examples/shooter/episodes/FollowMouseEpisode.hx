package examples.shooter.episodes;
import cinema.Episode;
import cinema.Hunter;
import examples.shooter.roles.MouseRole;
import examples.shooter.roles.PositionRole;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class FollowMouseEpisode extends BaseMouseEpisode
{
	public var hunter:Hunter;
	
	private var _objects:Array<PositionRole> = [];
	
	public function new() 
	{
		super();
	}
	
	override public function update(dt:Float):Void 
	{
		for (obj in _objects) {
			obj.x = mouse.x;
			obj.y = mouse.y;
		}
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		hunter = _createHunter(PositionRole, _objects);
	}
	
}