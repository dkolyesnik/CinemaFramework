package framework.common.roles;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Actor;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class SizeRole extends Role 
{

   // -- width property --
   public var width (get, set):Float;
   private var _widthProperty:FloatProperty;
   function get_width():Float { 
	   return _widthProperty.value;	
   }
   function set_width(value:Float):Float { 
	   return _widthProperty.value = value;
   }
	
	// -- height property --
	public var height (get, set):Float;
	private var _heightProperty:FloatProperty;
	function get_height():Float { 
		return _heightProperty.value;	
	}
	function set_height(value:Float):Float { 
		return _heightProperty.value = value;
	}
		
	
	
	public function new() 
	{
		super();
	}
	
	override function _readProperties():Void 
	{
		_widthProperty = cast(actor.getProperty("width"));
		_heightProperty = cast actor.getProperty("height");
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return actor.hasProperty("width") && actor.hasProperty("height");
	}
	
	override function _roleConstructor():Role 
	{
		return new SizeRole();
	}
	
	override function _setName():Void 
	{
		name = "SizeRole";
	}
}