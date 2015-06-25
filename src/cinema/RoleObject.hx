package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RoleObject
{
	public var actor(default, null):Actor;
	public var role(default, null):Role;
	public function new() 
	{
		
	}
	
	//TODO either remove either rename
	@:allow(cinema.Role)
	private function _initialize(p_actor:Actor, p_role:Role):RoleObject {
		actor = p_actor;
		role = p_role;
		_readProperties();
		return this;
	}
	
	private function _readProperties():Void {
		
	}
	
	private function _initializeSubRoleObjects():Void {
		
	}
	
}