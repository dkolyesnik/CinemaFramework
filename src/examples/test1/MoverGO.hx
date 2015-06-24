package examples.test1;
import cinema.Entity;
import cinema.GameObject;
import cinema.properties.IntProperty;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoverGO extends GameObject
{
	private var _xProperty:IntProperty;
	private var _yProperty:IntProperty;
	
	public var y (get, set):Int;
	public var x (get, set):Int;
	
	
	function get_x():Int { 
		return _xProperty.value;	
	}
	function set_x(value:Int):Int { 
	   return _xProperty.value = value;
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
		_xProperty = cast(entity.getProperty("x"));
		_yProperty = cast entity.getProperty("y");
	}
}