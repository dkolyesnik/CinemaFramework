package cinema.properties;
import cinema.Entity;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Property
{
	
	public function new() 
	{
		
	}
	
	@:allow(cinema.Entity)
	private function _onAdd(entity:Entity):Void {
		
	}
	
	@:allow(cinema.Entity)
	private function _onRemove(entity:Entity):Void {
		
	}
}