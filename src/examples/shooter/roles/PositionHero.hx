package examples.shooter.roles;
import cinema.Actor;
import cinema.Hero;
import cinema.properties.IntProperty;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionHero extends Hero
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
}