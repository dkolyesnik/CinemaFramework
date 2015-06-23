package core.role;
import core.role.GameObjectDef;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class GameObject
{

	public var entity(default, null):Entity;
	public var type(default, null):GameObjectDef;
	
	
	public function new() 
	{
		
	}
	
	public function initialize(entity:Entity):GameObject {
		this.entity = entity;
		return this;
	}
}