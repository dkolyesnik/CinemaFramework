package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class GameObject
{
	public var entity(default, null):Entity;
	public var goDef(default, null):GameObjectDef;
	public function new() 
	{
		
	}
	
	//TODO either remove either rename
	public function initialize(p_entity:Entity, p_goDef:GameObjectDef):GameObject {
		entity = p_entity;
		goDef = p_goDef;
		_readProperties();
		return this;
	}
	
	public function update(dt:Float):Void {
		
	}
	
	private function _readProperties():Void {
		
	}
	
}