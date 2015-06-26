package examples.shooter.roles;

import cinema.Hero;
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
	
	override function _heroConstructor():Hero 
	{
		return new MovingRole();
	}
	
}