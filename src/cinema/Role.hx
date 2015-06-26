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
		return _heroConstructor()._initialize(actor, this);
	}
	
	private function _heroConstructor():Hero {
		return new Hero();
	}
}