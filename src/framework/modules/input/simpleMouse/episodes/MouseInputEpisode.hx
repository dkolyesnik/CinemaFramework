package framework.modules.input.simpleMouse.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Story;
import framework.modules.input.simpleMouse.tags.MouseTags;
import framework.modules.input.simpleMouse.roles.MouseRole;
import framework.common.roles.PositionRole;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MouseInputEpisode extends Episode
{

	public var hunter:Hunter;
	
	private var _mouseArray:Array<MouseRole> = [];
	
	private var _localX:Float = 0;
	private var _localY:Float = 0;
	private var _stageX:Float = 0;
	private var _stageY:Float = 0;
	
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
			actor.addProperty("mouseLocalX", 0.0);
			actor.addProperty("mouseLocalY", 0.0);
			actor.addProperty("mouseStageX", 0.0);
			actor.addProperty("mouseStageY", 0.0);
		}
		_stage.addEventListener(MouseEvent.CLICK, clickHandler);
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
	}
	
	
	override function _destroy():Void 
	{
		_stage.removeEventListener(MouseEvent.CLICK, clickHandler);
		_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		super._destroy();
	}

	
	
	
	override public function update(dt:Float):Void 
	{
		for (mouse in _mouseArray) {
			mouse.localX = _localX;
			mouse.localY = _localY;
			mouse.stageX = _stageX;
			mouse.stageY = _stageY;
			if (_isClicked) {
				mouse.actor.addTag(MouseTags.CLICK);
			}else {
				mouse.actor.removeTag(MouseTags.CLICK);
			}
			if (_isMouseDown) {
				mouse.actor.addTag(MouseTags.IS_DOWN);
			}else {
				mouse.actor.removeTag(MouseTags.IS_DOWN);
			}
			if (_isMousePressed) {
				mouse.actor.addTag(MouseTags.PRESSED);
			}else {
				mouse.actor.removeTag(MouseTags.PRESSED);
			}
			if (_isMouseReleased) {
				mouse.actor.addTag(MouseTags.RELEASED);
			}else {
				mouse.actor.removeTag(MouseTags.RELEASED);
			}
		}
	}
	
	override public function postUpdate():Void 
	{
		_isClicked = false;
		_isMousePressed = false;
		_isMouseReleased = false;
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

	
	//  handlers
	
	private function mouseDownHandler(e:MouseEvent):Void 
	{
		_isMouseDown = true;
		_isMousePressed = true;
	}
	
	
	private function mouseUpHandler(e:MouseEvent):Void 
	{
		_isMouseDown = false;
		_isMouseReleased = true;
	}
	
	private function clickHandler(e:MouseEvent):Void 
	{
		_isClicked = true;
	}
	
	private function mouseMoveHandler(e:MouseEvent):Void 
	{
		_localX = e.localX;
		_localY = e.localY;
		_stageX = e.stageX;
		_stageY = e.stageY;
	}
	
}