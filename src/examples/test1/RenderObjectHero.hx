package examples.test1;
import cinema.Actor;
import cinema.Hero;
import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RenderObjectHero extends Hero
{
	private var _xProperty:IntProperty;
	private var _yProperty:IntProperty;
	private var _radiusProperty:IntProperty;
	
	public var radius(get, set):Int;
	public var y (get, set):Int;
	public var x (get, set):Int;
	
	function get_x():Int {
	   return _xProperty.value;
	}
	function set_x(value:Int):Int {
	   return _xProperty.value = value;
	}
		
	function get_radius():Int 
	{
		return _radiusProperty.value;
	}
	function set_radius(value:Int):Int 
	{
		return _radiusProperty.value = value;
	}
	
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
		_radiusProperty = cast actor.getProperty("radius");
	}
}