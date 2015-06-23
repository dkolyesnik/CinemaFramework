package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Episode
{

	public function new() 
	{
		
	}
	
	@:allow(cinema.Story)
	private function _initialize(story:Story):Void {
		_story = story;
		for (character in _characters) {
			_story._addCharacter(character);
		}
	}
	
	/* called when story is ended
	 * rough deleting everithng
	 */
	@:allow(cinema.Story)
	private function _destroy():Void {
		
	}
	
	//RENAME
	public function update(dt:Float):Void {
		
	}
	
	private function _createCharacter(roleClass:Class<Role>, heroesArray:Array<Dynamic> = null):Character {
		var character = new Character(roleClass, heroesArray);
		_characters.push(character);
		return character;
	}
	
	private var _story:Story;
	private var _characters:Array<Character> = [];
}