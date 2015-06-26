package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Role
{
	public var actor(default, null):Actor;
	
	public function new() 
	{
		
	}
	
	public function checkRequirements(actor:Actor):Bool {
		return true;
	}
	
	public function createRole(actor:Actor):Role {
		return _roleConstructor()._initialize(actor);
	}
	
	private function _roleConstructor():Role {
		return new Role();
	}
	
	//TODO either remove either rename
	@:allow(cinema.RoleDef)
	private function _initialize(p_actor:Actor):Role {
		actor = p_actor;
		_readProperties();
		return this;
	}
	
	private function _readProperties():Void {
		
	}
	
	
	
}