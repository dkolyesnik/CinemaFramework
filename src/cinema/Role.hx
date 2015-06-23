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
	
	public function createHero(actor:Actor):Hero {
		return _heroCunstructor().initialize(actor, this);
	}
	
	private function _heroCunstructor():Hero {
		return new Hero();
	}
}