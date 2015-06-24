package examples.test1;

import examples.test1.RenderObjectGO;
import cinema.Entity;
import cinema.GameObject;
import cinema.GameObjectDef;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RenderObjectGODef extends GameObjectDef
{

	public function new() 
	{
		super();
		
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y", "radius"];
	}
	
	override function _goConstructor():GameObject 
	{
		return new RenderObjectGO();
	}
}