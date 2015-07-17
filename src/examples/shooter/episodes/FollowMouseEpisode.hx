package examples.shooter.episodes;
import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
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
	public var hunter:Hunter<PositionRole>;
	
	public function new() 
	{
		super();
	}
	
	override public function update(dt:Float):Void 
	{
		for (obj in hunter) {
			obj.x = mouse.stageX;
			obj.y = mouse.stageY;
		}
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new PositionRole());
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		hunter = new Hunter<PositionRole>(PositionRole.NAME);
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		_hunters.push( cast hunter);
	}
	
	
}