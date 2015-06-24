package examples.test1;

import cinema.Actor;
import cinema.Hunter;
import cinema.Hero;
import cinema.Episode;
import cinema.Story;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RandomActionEpisode extends Episode
{
	public var hunter:Hunter;
	
	private var _chance:Int;
	private var _foo:Actor->Void;
	
	public function new(p_story:Story, chance:Int, foo:Actor->Void) 
	{
		super(p_story);
		
		_chance = chance;
		_foo = foo;
	}
	
	override function _setupHunters():Void 
	{
		hunter = _createHunter(RenderObjectRole);
	}
	
	override public function update(dt:Float):Void 
	{
		var array:Array<Hero> = hunter.heroes;
		for (hero in array) {
			if (Math.random() * 100 > _chance) {
				_foo(hero.actor);
			}
		}
	}
	
}