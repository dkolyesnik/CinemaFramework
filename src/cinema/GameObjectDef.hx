package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class GameObjectDef
{
	public var requirements(default, null):Array<String>;
	
	public function new() 
	{
		_setRequirements();
	}
	
	private function _setRequirements():Void {
		requirements = [];
	}
	
	public function createGO(entity:Entity):GameObject {
		return _goConstructor().initialize(entity, this);
	}
	
	private function _goConstructor():GameObject {
		return new GameObject();
	}
}