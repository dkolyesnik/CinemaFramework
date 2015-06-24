package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Process
{

	public function new() 
	{
		_initializeSelectors();
	}
	
	private function _initializeSelectors():Void {
		
	}
	
	@:allow(cinema.Core)
	private function _initialize(core:Core):Void {
		_core = core;
		for (selector in _selectors) {
			_core._addSelector(selector);
		}
	}
	
	/* called when core is ended
	 * rough deleting everithng
	 */
	@:allow(cinema.Core)
	private function _destroy():Void {
		
	}
	
	//RENAME
	public function update(dt:Float):Void {
		
	}
	
	private function _createSelector(goDefClass:Class<GameObjectDef>, goesArray:Array<Dynamic> = null):Selector {
		var selector = new Selector(goDefClass, goesArray);
		_selectors.push(selector);
		return selector;
	}
	
	private var _core:Core;
	private var _selectors:Array<Selector> = [];
}