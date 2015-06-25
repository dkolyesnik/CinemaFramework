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
	
	private function _setupHunters():Void {
		
	}
	
	@:allow(cinema.Story)
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
	
	//RENAME
	public function update(dt:Float):Void {
		
	}
	
	private function _createHunter(roleClass:Class<Role>, roleObjectesArray:Array<Dynamic> = null):Hunter {
		var hunter = new Hunter(roleClass, roleObjectesArray);
		_hunters.push(hunter);
		return hunter;
	}
	
	private var _story:Story;
	private var _hunters:Array<Hunter> = [];
}