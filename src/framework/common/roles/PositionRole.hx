package framework.common.roles;
import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.Role;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionRole extends Role
{
	static public inline var NAME = "PositionRole";
	
	// -- x property --
	public var x (get, set):Float;
	private var _xProperty:FloatProperty;
	private inline function get_x():Float { 
		return _xProperty.value;	
	}
	private inline function set_x(value:Float):Float { 
	   return _xProperty.value = value;
	}
	
	// -- y property --
	public var y (get, set):Float;
	private var _yProperty:FloatProperty;
	private inline function get_y():Float {
	   return _yProperty.value;
	}
	private inline function set_y(value:Float):Float {
	   return _yProperty.value = value;
	}
		
	
	
	public function new() 
	{
		super();
	}
	
	override function _readProperties():Void 
	{
		_xProperty = cast actor.getProperty("x");
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
	
	override function get_roleName():String
	{
		return NAME;
	}
}