package examples.shooter.roles;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Actor;
import examples.shooter.episodes.misc.MouseTags;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class MouseRole extends Role 
{

	// -- x property --
	public var x (get, set):Float;
	private var _xProperty:FloatProperty;
	function get_x():Float { 
		return _xProperty.value;	
	}
	function set_x(value:Float):Float { 
		return _xProperty.value = value;
	}
	
	// -- y property --
	public var y (get, set):Float;
	private var _yProperty:FloatProperty;
	function get_y():Float { 
		return _yProperty.value;	
	}
	function set_y(value:Float):Float { 
		return _yProperty.value = value;
	}
	
    public function new() 
    {
        super();
    }
	
	public function isClicked():Bool {
		return actor.hasTag(MouseTags.CLICK);
	}
	
	
	// ----- Role ---------
	override function _readProperties():Void 
	{
		_xProperty = cast actor.getProperty("mouseX");
		_yProperty = cast actor.getProperty("mouseY");
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return actor.hasProperty("mouseX") && actor.hasProperty("mouseY");
	}
	
	override function _roleConstructor():Role 
	{
		return new MouseRole();
	}
	
	override function _setName():Void 
	{
		name = "MouseRole";
	}
}