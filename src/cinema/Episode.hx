package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Episode
{

	public function new()
	{
		_setupHunters();
	}
	/**
	 *  Override to setup Hunters
	 */
	private function _setupHunters():Void {
		
	}
	
	@:allow(cinema.Story)
	/**
	 * Called when added to Story
	 * @param	story
	 */
	private function _initialize(story:Story):Void {
		_story = story;
		for (hunter in _hunters) {
			_story._addHunter(hunter);
		}
	}
	
	/* called when story is ended
	 * rough deleting everithng
	 */
	@:allow(cinema.Story)
	private function _destroy():Void {
		_hunters = null;
		_story = null;
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
	
	private  function _createHunter(roleClass:Class<Role>, rolesArray:Array<Dynamic> = null):Hunter {
		var hunter = new Hunter(roleClass, rolesArray);
		_hunters.push(hunter);
		return hunter;
	}
	
	private var _story:Story;
	private var _hunters:Array<Hunter> = [];
}