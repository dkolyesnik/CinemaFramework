package examples.test1;
import cinema.Selector;
import cinema.GameObject;
import cinema.Process;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoveProcess extends Process
{
	public var moveableSelector:Selector;
	
	private var _movebleObjects:Array<MoverGO> = [];
	
	public function new() 
	{
		super();
		
		moveableSelector = _createSelector(MoverGODef, _movebleObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		for (moveable in _movebleObjects) {
			moveable.x += Std.int(Math.random() * 4 - 2);
			moveable.y += Std.int(Math.random() * 4 - 2);
		}
	}
}