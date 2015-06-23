package examples.test1;

import cinema.Actor;
import cinema.Character;
import cinema.Hero;
import cinema.Episode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RandomActionEpisode extends Episode
{
	public var character:Character;
	
	private var _chance:Int;
	private var _foo:Actor->Void;
	
	public function new(chance:Int, foo:Actor->Void) 
	{
		super();
		character = _createCharacter(RenderObjectRole);
		_chance = chance;
		_foo = foo;
	}
	
	override public function update(dt:Float):Void 
	{
		var array:Array<Hero> = character.heroes;
		for (hero in array) {
			if (Math.random() * 100 > _chance) {
				_foo(hero.actor);
			}
		}
	}
	
}