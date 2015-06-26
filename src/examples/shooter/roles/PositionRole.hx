package examples.shooter.roleDefs;
import cinema.Actor;
import cinema.Role;
import cinema.properties.IntProperty;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionRole extends Role
{
	// -- x property --
	public var x (get, set):Int;
	private var _xProperty:IntProperty;
	function get_x():Int { 
		return _xProperty.value;	
	}
	function set_x(value:Int):Int { 
	   return _xProperty.value = value;
	}
	
	// -- y property --
	public var y (get, set):Int;
	private var _yProperty:IntProperty;
	function get_y():Int {
	   return _yProperty.value;
	}
	function set_y(value:Int):Int {
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