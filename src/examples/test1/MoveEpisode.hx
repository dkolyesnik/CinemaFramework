package examples.test1;
import cinema.Character;
import cinema.Hero;
import cinema.Episode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoveEpisode extends Episode
{
	public var moveableCharacter:Character;
	
	private var _movebleObjects:Array<MoverHero> = [];
	
	public function new() 
	{
		super();
		
		moveableCharacter = _createCharacter(MoverRole, _movebleObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		for (moveable in _movebleObjects) {
			moveable.x += Std.int(Math.random() * 4 - 2);
			moveable.y += Std.int(Math.random() * 4 - 2);
		}
	}
}