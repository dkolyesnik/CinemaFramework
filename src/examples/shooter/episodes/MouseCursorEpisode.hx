package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Story;
import examples.shooter.roles.PositionRole;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MouseCursorEpisode extends Episode
{

	public var hunter:Hunter;
	
	private var _mouseArray:Array<PositionRole> = [];
	
	private var _mouseX:Float = 0;
	private var _mouseY:Float = 0;
	
	private var _stage:Sprite;
	
	public function new(stage:Sprite) 
	{
		super();
		_stage = stage;
	}
	
	override function _initialize(story:Story):Void 
	{
		super._initialize(story);
		if (story.findActor("mouse") == null) {
			var actor = story.createActor("mouse");
			actor.addProperty("x", new FloatProperty(0));
			actor.addProperty("y", new FloatProperty(0));
		}
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
	}
	
	override function _destroy():Void 
	{
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		super._destroy();
	}
	
	private function mouseMoveHandler(e:MouseEvent):Void 
	{
		_mouseX = e.stageX;
		_mouseY = e.stageY;
	}
	
	override public function update(dt:Float):Void 
	{
		for (mouse in _mouseArray) {
			mouse.x = _mouseX;
			mouse.y = _mouseY;
		}
	}
	
	override function _setupHunters():Void 
	{
		hunter = _createHunter(PositionRole, _mouseArray);
		hunter.filter.actorName("mouse");
	}
	
	override function _createHunter(roleClass:Class<Role>, rolesArray:Array<Dynamic> = null):Hunter 
	{
		return super._createHunter(roleClass, rolesArray);
	}
	
}