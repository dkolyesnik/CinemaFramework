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
	public var hunter:Hunter<RenderRole>;
	
	private var _chance:Int;
	private var _foo:Actor->Void;
	
	public function new(chance:Int, foo:Actor->Void) 
	{
		super();
		
		_chance = chance;
		_foo = foo;
	}
	
	override function _createHunters() 
	{
		hunter = new Hunter<RenderRole>(RenderRole.NAME);
	}
	
	override function _addHunters() 
	{
		_hunters.push(cast hunter);
	}
	
	//override fun():Void 
	//{
		//hunter = new Hunter<RenderRole>();
		//
		//_hunters.push(cast hunter);
	//}
	
	override public function update(dt:Float):Void 
	{
		for (role in hunter) 
		{
			if (Math.random() * 100 > _chance) 
			{
				_foo(role.actor);
			}
		}
	}
	
}