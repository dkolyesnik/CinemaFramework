package framework.modules.input.simpleMouse.roles;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Actor;
import framework.modules.input.simpleMouse.tags.MouseTags;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class MouseRole extends Role 
{

	// -- localX property --
	public var localX (get, set):Float;
	private var _localXProperty:FloatProperty;
	function get_localX():Float { 
		return _localXProperty.value;	
	}
	function set_localX(value:Float):Float { 
		return _localXProperty.value = value;
	}
	
	// -- localY property --
	public var localY (get, set):Float;
	private var _localYProperty:FloatProperty;
	function get_localY():Float { 
		return _localYProperty.value;	
	}
	function set_localY(value:Float):Float { 
		return _localYProperty.value = value;
	}
	
	// -- stageX property --
	public var stageX (get, set):Float;
	private var _stageXProperty:FloatProperty;
	function get_stageX():Float { 
		return _stageXProperty.value;	
	}
	function set_stageX(value:Float):Float { 
		return _stageXProperty.value = value;
	}
	
	// -- stageY property --
	public var stageY (get, set):Float;
	private var _stageYProperty:FloatProperty;
	function get_stageY():Float { 
		return _stageYProperty.value;	
	}
	function set_stageY(value:Float):Float { 
		return _stageYProperty.value = value;
	}
	
    public function new() 
    {
        super();
    }
	
	public function isClicked():Bool {
		return actor.hasTag(MouseTags.CLICK);
	}
	
	public function isPressed():Bool {
		return actor.hasTag(MouseTags.PRESSED);
	}
	
	public function isReleased():Bool {
		return actor.hasTag(MouseTags.RELEASED);
	}
	
	public function isDown():Bool {
		return actor.hasTag(MouseTags.IS_DOWN);
	}
	
	
	// ----- Role ---------
	override function _readProperties():Void 
	{
		_localXProperty = cast actor.getProperty("mouseLocalX");
		_localYProperty = cast actor.getProperty("mouseLocalY");
		_stageXProperty = cast actor.getProperty("mouseStageX");
		_stageYProperty = cast actor.getProperty("mouseStageY");
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return actor.hasProperty("mouseLocalX") && actor.hasProperty("mouseLocalY") && actor.hasProperty("mouseStageX") && actor.hasProperty("mouseStageY");
	}
	
	override function _roleConstructor():Role 
	{
		return new MouseRole();
	}
	
	override function get_name():String 
	{
		return name;
	}
	
	public static inline var name = "MouseRole";
}