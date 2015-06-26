package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RoleDef
{
	public var requirements(default, null):Array<String>;
	
	public function new() 
	{
		_setRequirements();
	}
	
	private function _setRequirements():Void {
		requirements = [];
	}
	
	public function createRole(actor:Actor):Role {
		return _roleConstructor()._initialize(actor, this);
	}
	
	private function _roleConstructor():Role {
		return new Role();
	}
}