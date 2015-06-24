package examples.test1;
import cinema.Entity;
import cinema.GameObject;
import cinema.GameObjectDef;


/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoverGODef extends GameObjectDef
{

	public function new() 
	{
		super();
	}
	
	override function _setRequirements():Void 
	{
		requirements = ["x", "y"];
	}
	
	override function _goConstructor():GameObject 
	{
		return new MoverGO();
	}
	
}