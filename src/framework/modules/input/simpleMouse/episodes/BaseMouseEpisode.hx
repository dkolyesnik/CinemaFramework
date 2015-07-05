package framework.modules.input.simpleMouse.episodes;
import cinema.Episode;
import cinema.Hunter;
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
	private var _mouseHunter:Hunter;
	private var _mouseArray:Array<MouseRole> = []; 
	
	private var mouse:MouseRole;
	
	public function new() 
	{
		super();
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		_mouseHunter = _createHunter(MouseRole, _mouseArray);
		_mouseHunter.filter.actorName("mouse");
	}

	override public function preUpdate():Bool 
	{
		super.preUpdate();
		if (_mouseArray.length == 0)
			return false;
		mouse = _mouseArray[0];
		return true;
	}
	
	override public function update(dt:Float):Void 
	{
	}
}