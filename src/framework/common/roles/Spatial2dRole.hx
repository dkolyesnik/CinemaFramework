package framework.common.roles;
import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.Role;
import framework.common.roles.PositionRole;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class Spatial2dRole extends PositionRole 
{
	// -- rotation property --
	public var rotation (get, set):Float;
	private var _rotationProperty:FloatProperty;
	function get_rotation():Float { 
		return _rotationProperty.value;	
	}
	function set_rotation(value:Float):Float { 
		return _rotationProperty.value = value;
	}
	
	
    public function new() 
    {
        
    }
	override function _initialize(p_actor:Actor):Role 
	{
		super._initialize(p_actor);
		_rotationProperty = cast p_actor.getProperty("rotation");
		
		return this;
	}
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("rotation");
	}
	
	override function _roleConstructor():Role 
	{
		return new Spatial2dRole();
	}
	
	override function _setName():Void 
	{
		name = "Spatial2dRole";
	}
}