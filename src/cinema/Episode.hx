package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Episode
{

	public function new(p_story:Story)
	{
		_story = p_story;
		_setupHunters();
	}
	
	private function _setupHunters():Void {
		
	}
	
	
	public function initialize():Void {
		_story._addEpisode(this);
	}
	//@:allow(cinema.Story)
	//private function _initialize(story:Story):Void {
		//_story = story;
		//for (hunter in _hunters) {
			//_story._addHunter(hunter);
		//}
	//}
	
	/* called when story is ended
	 * rough deleting everithng
	 */
	@:allow(cinema.Story)
	private function _destroy():Void {
		
	}
	
	//RENAME
	public function update(dt:Float):Void {
		
	}
	
	private function _createHunter(roleClass:Class<Role>, heroesArray:Array<Dynamic> = null):Hunter {
		var hunter = new Hunter(roleClass, heroesArray);
		_hunters.push(hunter);
		_story._addHunter(hunter);
		return hunter;
	}
	
	private var _story:Story;
	private var _hunters:Array<Hunter> = [];
}