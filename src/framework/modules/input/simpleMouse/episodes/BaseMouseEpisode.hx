package framework.modules.input.simpleMouse.episodes;
import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import cinema.Story;
import framework.modules.input.simpleMouse.roles.MouseRole;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class BaseMouseEpisode extends Episode
{
	private var _mouseHunter:Hunter<MouseRole>;
	
	private var mouse:MouseRole;
	
	public function new() 
	{
		super();
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new MouseRole());
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		_mouseHunter = new Hunter<MouseRole>(MouseRole.NAME);
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		_hunters.push( cast _mouseHunter);
	}
	
	override public function preUpdate():Bool 
	{
		super.preUpdate();
		for (mouseRole in _mouseHunter)
		{
			mouse = mouseRole;
			return true;
		}
		return false;
	}
	
	override public function update(dt:Float):Void 
	{
	}
}