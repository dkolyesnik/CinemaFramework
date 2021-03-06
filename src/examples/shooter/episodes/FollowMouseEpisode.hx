package examples.shooter.episodes;
import cinema.Episode;
import cinema.Hunter;
import framework.modules.input.simpleMouse.episodes.BaseMouseEpisode;
import framework.modules.input.simpleMouse.roles.MouseRole;
import framework.common.roles.PositionRole;
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
			obj.x = mouse.stageX;
			obj.y = mouse.stageY;
		}
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		hunter = _createHunter(PositionRole, _objects);
	}
	
}