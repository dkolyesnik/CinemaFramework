package cinema.properties;
import cinema.Actor;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Property
{
	
	public function new() 
	{
		
	}
	
	@:allow(cinema.Actor)
	private function _onAdd(actor:Actor):Void {
		
	}
	
	@:allow(cinema.Actor)
	private function _onRemove(actor:Actor):Void {
		
	}
}