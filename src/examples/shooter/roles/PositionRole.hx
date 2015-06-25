package examples.test1;
import cinema.Actor;
import cinema.RoleObject;
import cinema.Role;


/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionRole extends Role
{

	public function new() 
	{
		super();
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y"];
	}
	
	override function _roleObjectConstructor():RoleObject 
	{
		return new PositionRole();
	}
	
}