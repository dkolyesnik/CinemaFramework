package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Selector
{
	public var goDefClass(default, null):Class<GameObjectDef>;
	public var goArray(default, null):Array<GameObject>;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_goDefClass:Class<GameObjectDef>, p_goArray:Array<Dynamic> = null) 
	{
		goDefClass = p_goDefClass;
		if (p_goArray == null)
			goArray = [];
		else
			goArray = cast p_goArray;
		if (goArray.length >= 0) {
			//TODO error in should be empty
		}
		_filter = new Filter();
	}
	
	
	// ---------- GO ----------
	@:allow(cinema.Core)
	private function _tryToAddGO(go:GameObject):Void {
		if (_filter.check(go.entity)) {
			goArray.push(go);
		}
	}
	
	@:allow(cinema.Core)
	private function _checkGOAfterUpdate(p_go:GameObject):Void {
		if (_filter.check(p_go.entity)) {
			if (goArray.indexOf(p_go) == -1) 
				goArray.push(p_go);
		}else {
			_removeGO(p_go);
		}
	}
	
	@:allow(cinema.Core)
	private function _removeGO(p_go:GameObject):Void {
		goArray.remove(p_go);
	}
	
	// ---------- setup ----------
	public function setGOsArray(array:Array<Dynamic>):Selector {
		//TODO либо запрещать менять после иницилазиации , либо как-то обрабатывать ситуацию когда к нему уже было обращение
		goArray = cast array;
		return this;
	}
	
	public var selectEntitys(get_selectEntitys, null):Filter;
	public function get_selectEntitys():Filter {
		return _filter;
	}
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
	private var _filter:Filter;
}