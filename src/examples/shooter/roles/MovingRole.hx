package examples.shooter.roles;

import cinema.RoleObject;
import examples.test1.PositionRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MovingRole extends PositionRole
{

	public function new() 
	{
		super();
		
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y", "speed"];
	}
	
	override function _roleObjectConstructor():RoleObject 
	{
		return new MovingRole();
	}
	
}