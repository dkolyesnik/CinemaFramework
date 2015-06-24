package examples.test1;

import examples.test1.RenderObjectHero;
import cinema.Actor;
import cinema.Hero;
import cinema.Role;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RenderObjectRole extends Role
{

	public function new() 
	{
		super();
		
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y", "radius"];
	}
	
	override function _heroCunstructor():Hero 
	{
		return new RenderObjectHero();
	}
}