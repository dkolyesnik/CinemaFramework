package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Role
{
	public var requirements(default, null):Array<String>;
	
	public function new() 
	{
		_setRequirements();
	}
	
	private function _setRequirements():Void {
		requirements = [];
	}
	
	public function createRoleObject(actor:Actor):RoleObject {
		return _roleObjectConstructor()._initialize(actor, this);
	}
	
	private function _roleObjectConstructor():RoleObject {
		return new RoleObject();
	}
}