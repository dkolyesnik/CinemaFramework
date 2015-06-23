package core.role;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class GameObjectDef
{

	public var requiredProperties(default, null):Array<String>;
	public var id(default, null):String;
	
	public function new() 
	{
		
	}
	
	//private function _setRequirements(p_requirements:Array<String>):Void {
		//requiredProperties = p_requirements;
	//}
	
	public function createRole(entity:Entity):GameObject {
		return new GameObject().initialize(entity);
	}
	
	//TODO move to some util class, or use other lib
	//private function strSort(a:String, b:String):Int
    //{
        //a = a.toLowerCase();
        //b = b.toLowerCase();
       //
        //if (a < b) return -1;
        //if (a > b) return 1;
        //return 0;
    //}
	
}