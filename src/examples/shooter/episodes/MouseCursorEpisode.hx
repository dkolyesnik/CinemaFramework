package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Story;
import examples.shooter.episodes.misc.MouseTags;
import examples.shooter.roles.MouseRole;
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
	
	private var _mouseArray:Array<MouseRole> = [];
	
	private var _mouseX:Float = 0;
	private var _mouseY:Float = 0;
	
	private var _stage:Sprite;
	
	private var _isClicked:Bool = false;
	private var _isMouseDown:Bool = false;
	private var _isMousePressed:Bool = false;
	private var _isMouseReleased:Bool = false;

	
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
			actor.addProperty("mouseX", new FloatProperty(0));
			actor.addProperty("mouseY", new FloatProperty(0));
		}
		_stage.addEventListener(MouseEvent.CLICK, clickHandler);
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
	}
	
	override function _destroy():Void 
	{
		_stage.removeEventListener(MouseEvent.CLICK, clickHandler);
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		super._destroy();
	}

	private function mouseDownHandler(e:MouseEvent):Void {

	}
	
	private function clickHandler(e:MouseEvent):Void 
	{
		_isClicked = true;
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
			if (_isClicked) {
				mouse.actor.addTag(MouseTags.CLICK);
			}else {
				mouse.actor.removeTag(MouseTags.CLICK);
			}
		}
	}
	
	override public function postUpdate():Void 
	{
		_isClicked = false;
	}

	override function _setupHunters():Void 
	{
		hunter = _createHunter(MouseRole, _mouseArray);
		hunter.filter.actorName("mouse");
	}
	
	override function _createHunter(roleClass:Class<Role>, rolesArray:Array<Dynamic> = null):Hunter 
	{
		return super._createHunter(roleClass, rolesArray);
	}

	
}