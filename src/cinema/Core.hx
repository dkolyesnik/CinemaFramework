package cinema;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Core
{

	/*
	 * идеии на будущее
	 * добавить пулы под актеров 
	 * добавить инфу для дебага, количество сущностей, пиковое количество суностей 
	 * дополнительные проверки, возможно какое-то логирование 
	 * 
	 * добавить базовых героев для частых случаем PositionGO , SpatialGO и тд
	 * 
	 */
	
	public function new() 
	{
		
	}
	public function begin():Void {
		_hasBegan = true;
	}
	
	public function update(dt:Float):Void {
		//TODO better name and checking if hasBegan
		for (entity in _entitysToAdd) {
			_addEntity(entity);
		}
		clearArray(_entitysToAdd);
		for (episode in _episodes) {
			episode.update(dt);
		}
	}
	
	public function end():Void {
		_hasBegan = false;
		//TODO удаление сего 
		for (episode in _episodes) {
			episode._destroy();
		}
		for (entity in _entitys) {
			entity._destroy();
		}
		_episodes = null;
		_entitys = null;
		_entitysToAdd = null;
		_selectorsByGODefName = null;
		_goDefsByName = null;
		_hasBegan = false;
	}
	
	// ---------- Scenarios ----------
	public function addProcess(process:Process):Void {
		if (_hasBegan) {
			return;
		}
		_episodes.push(process);
		process._initialize(this);
	}
	
	// ---------- Entitys ----------
	public function allocateEntity():Entity {
		var entity = new Entity();
		_entitysToAdd.push(entity);
		return entity;
	}
	
	public function removeEntity(entity:Entity):Void {
		if (_entitys.remove(entity)) {
			entity._destroy();
		}
	}
	
	private function _addEntity(entity:Entity):Void {
		//TODO = optimize
		entity._initialize(this);
		var selectors:Array<Selector>;
		var goDef:GameObjectDef;
		var go:GameObject;
		for (goDefName in _goDefsByName.keys()) {
			goDef = _goDefsByName.get(goDefName);
			if (entity.hasProperties(goDef.requirements)) {
				go = goDef.createGO(entity);
				entity._addGO(go);
				selectors = _selectorsByGODefName.get(goDefName);
				for (selector in selectors) {
					selector._tryToAddGO(go);
				}
			}
		}
	}
	
	@:allow(cinema.Entity)
	private function _entityRecievedProperty(entity:Entity):Void {
		var selectors:Array<Selector>;
		var goDef:GameObjectDef;
		var go:GameObject;
		for (goDefName in _goDefsByName.keys()) {
			goDef = _goDefsByName.get(goDefName);
			if (entity.hasProperties(goDef.requirements) && !entity._hasGOForGODef(goDef)) {
				go = goDef.createGO(entity);
				entity._addGO(go);
				selectors = _selectorsByGODefName.get(goDefName);
				for (selector in selectors) {
					selector._tryToAddGO(go);
				}
			}
		}
	}
	
	@:allow(cinema.Entity)
	private function _entityLostProperty(go:GameObject):Void {
		var goDefName = Type.getClassName(Type.getClass(go.goDef));
		var goDef:GameObjectDef = _goDefsByName.get(goDefName);
		if (!go.entity.hasProperties(goDef.requirements)) {
			var selectorsArray = _selectorsByGODefName.get(goDefName);
			for (selector in selectorsArray) {
				selector._removeGO(go);
			}
		}
	}
	
	@:allow(cinema.Entity)
	private function _entityTagsModified(go:GameObject):Void {
		var goDefName = Type.getClassName(Type.getClass(go.goDef));
		var selectorsArray = _selectorsByGODefName.get(goDefName);
		for (selector in selectorsArray) {
			selector._checkGOAfterUpdate(go);
		}
	}
	
	@:allow(cinema.Entity)
	private function _removeGOFromSelectors(go:GameObject):Void {
		var goDefName = Type.getClassName(Type.getClass(go.goDef));
		var selectorsArray = _selectorsByGODefName.get(goDefName);
		for (selector in selectorsArray) {
			selector._removeGO(go);
		}
	}
		
	// ---------- Selectors ----------
	@:allow(cinema.Process)
	private function _addSelector(selector:Selector):Void {
		var goDefName:String = Type.getClassName(selector.goDefClass);
		var goDefClass:Class<GameObjectDef> = selector.goDefClass;
		var array = _selectorsByGODefName.get(goDefName);
		if (array == null) {
			array = [];
			_selectorsByGODefName.set(goDefName, array);
			_goDefsByName.set(goDefName, Type.createInstance(goDefClass, []));
		}
		array.push(selector);
		
	}
	
	// ---------- vars ----------
	private var _hasBegan:Bool = false;
	private var _episodes:Array<Process> = [];
	private var _entitys:Array<Entity> = [];
	private var _entitysToAdd:Array<Entity> = [];
	//TODO  заменить на ObjectMap
	private var _selectorsByGODefName:Map<String, Array<Selector>> = new Map();
	private var _goDefsByName:Map<String, GameObjectDef> = new Map();
	
	//misc
	static inline function clearArray(array:Array<Entity>) {
		#if (cpp||php)
           array.splice(0,array.length);          
        #else
           untyped array.length = 0;
        #end
	}
	
}