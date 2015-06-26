package examples.shooter.roleDefs;
import cinema.Actor;
import cinema.Role;
import cinema.RoleDef;


/**
 * ...
 * @author Kolyesnik D.V.
 */
class PositionRoleDef extends RoleDef
{

	public function new() 
	{
		super();
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y"];
	}
	
	override function _roleConstructor():Role 
	{
		return new PositionRoleDef();
	}
	
}