package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Hero
{
	public var actor(default, null):Actor;
	public var role(default, null):Role;
	public function new() 
	{
		
	}
	
	//TODO either remove either rename
	public function initialize(p_actor:Actor, p_role:Role):Hero {
		actor = p_actor;
		role = p_role;
		_readProperties();
		return this;
	}
	
	private function _readProperties():Void {
		
	}
	
}