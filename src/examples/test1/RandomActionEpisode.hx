package examples.test1;

import cinema.Actor;
import cinema.Hunter;
import cinema.Role;
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
	
	public function new(chance:Int, foo:Actor->Void) 
	{
		super();
		
		_chance = chance;
		_foo = foo;
	}
	
	override function _setupHunters():Void 
	{
		hunter = _createHunter(RenderRole);
	}
	
	override public function update(dt:Float):Void 
	{
		var array:Array<Role> = hunter.roles;
		for (role in array) {
			if (Math.random() * 100 > _chance) {
				_foo(role.actor);
			}
		}
	}
	
}