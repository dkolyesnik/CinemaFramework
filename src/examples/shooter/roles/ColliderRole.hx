package examples.shooter.roles;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.Actor;
import framework.common.roles.PositionRole;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class ColliderRole extends PositionRole 
{
	// -- radius property --
	public var radius (get, set):Float;
	private var _radiusProperty:FloatProperty;
	function get_radius():Float { 
		return _radiusProperty.value;	
	}
	function set_radius(value:Float):Float { 
		return _radiusProperty.value = value;
	}
	
    public function new() 
    {
        super();
    }
	
	override function _readProperties():Void 
	{
		super._readProperties();
		_radiusProperty = cast actor.getProperty("radius");
		
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("radius");
	}
	
	override function _roleConstructor():Role 
	{
		return new ColliderRole();
	}
	
	override function _setName():Void 
	{
		name = "CollisionRole";
	}
}