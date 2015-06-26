package examples.shooter.roles;
import cinema.Actor;
import cinema.Hero;
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
	
	override function _heroConstructor():Hero 
	{
		return new PositionRole();
	}
	
}