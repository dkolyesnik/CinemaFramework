package examples.test1;

import cinema.Actor;
import cinema.Hero;
import cinema.Role;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RenderRole extends Role
{

	public function new() 
	{
		super();
		
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y", "radius"];
	}
	
	override function _heroConstructor():Hero 
	{
		return new RenderHero();
	}
}