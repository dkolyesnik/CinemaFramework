package examples.shooter.roles;
import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.Role;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionRole extends Role
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
	
	override function _readProperties():Void 
	{
		_xProperty = cast(actor.getProperty("x"));
		_yProperty = cast actor.getProperty("y");
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return actor.hasProperty("x") && actor.hasProperty("y");
	}
	
	override function _roleConstructor():Role 
	{
		return new PositionRole();
	}
	
	override function _setName():Void 
	{
		name = "Position";
	}
}