package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Role
{
	public var actor(default, null):Actor;
	
	public var roleDef(get, null):RoleDef;
	function get_roleDef():RoleDef 
	{
		return roleDef;
	}
	
	public function new() 
	{
		
	}
	
	//TODO either remove either rename
	@:allow(cinema.RoleDef)
	private function _initialize(p_actor:Actor, p_roleDef:RoleDef):Role {
		actor = p_actor;
		roleDef = p_roleDef;
		_readProperties();
		return this;
	}
	
	private function _readProperties():Void {
		
	}
	
	private function _initializeSubRoles():Void {
		
	}
	
}