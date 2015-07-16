package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Episode
{

	public function new()
	{
		_createHunters();
	}
	
	@:allow(cinema.Story)
	/**
	 * Called when added to Story
	 * @param	story
	 */
	private function _initialize(story:Story):Void 
	{
		_story = story;
		_registerRoleModels();
		_addHunters();
		for (hunter in _hunters) 
		{
			_story._addHunter(hunter);
		}
	}
	
	/* called when story is ended
	 * rough deleting everithng
	 */
	@:allow(cinema.Story)
	private function _destroy():Void 
	{
		_hunters = null;
		_story = null;
	}
	
	/**
	 * override to register RoleModels here
	 */
	private function _registerRoleModels()
	{
		
	}
	
	/**
	 * override to create hunters
	 */
	private function _createHunters()
	{
		
	}
	
	/**
	 * override to create hunters
	 */
	private function _addHunters()
	{
		
	}
	
	/**
	 * Called before update
	 */
	public function preUpdate():Bool {
		return true;
	}
	
	
	/**
	 * Override 
	 * @param	dt - delta time
	 */
	public function update(dt:Float):Void {
		
	}
	
	/**
	 * Called after update
	 */
	public function postUpdate():Void {
		
	}
	
	private var _story:Story;
	private var _hunters:Array<Hunter<Role>> = [];
}