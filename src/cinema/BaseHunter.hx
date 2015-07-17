package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class BaseHunter
{
	public var roleName(default, null):String;
	public var filter(default, null):Filter;
	
	
	public function new() 
	{
		
	}
	
	
	// ---------- Role ----------
	
		
	@:allow(cinema.Story)
	private function _tryToAddActor(actor:Actor):Void 
	{
		
	}
	
	@:allow(cinema.Story)
	private function _checkRoleAfterUpdate(p_role:Role):Void 
	{
		
	}
	
	
	
	
}