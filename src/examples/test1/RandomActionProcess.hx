package examples.test1;

import cinema.Entity;
import cinema.Selector;
import cinema.GameObject;
import cinema.Process;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RandomActionProcess extends Process
{
	public var selector:Selector;
	
	private var _chance:Int;
	private var _foo:Entity->Void;
	
	public function new(chance:Int, foo:Entity->Void) 
	{
		super();
		selector = _createSelector(RenderObjectGODef);
		_chance = chance;
		_foo = foo;
	}
	
	override public function update(dt:Float):Void 
	{
		var array:Array<GameObject> = selector.goArray;
		for (go in array) {
			if (Math.random() * 100 > _chance) {
				_foo(go.entity);
			}
		}
	}
	
}