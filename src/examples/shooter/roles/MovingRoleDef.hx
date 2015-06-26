package examples.shooter.roleDefs;

import cinema.Role;
import examples.test1.PositionRoleDef;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MovingRoleDef extends PositionRoleDef
{

	public function new() 
	{
		super();
		
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y", "speed"];
	}
	
	override function _roleConstructor():Role 
	{
		return new MovingRoleDef();
	}
	
}