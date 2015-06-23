package core.role;
import core.Entity;
import cinema.filters.FilterCondition;
import cinema.filters.Filter;
import core.role.GameObject;
import core.role.GameObjectDef;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Selector
{
	
	private var _filter:Filter;
	private var _roleDef:GameObjectDef;

	public function new(roleDef:GameObjectDef) 
	{
		_roleDef = roleDef;
		_filters = [];
		_filter = new Filter();
		_activeRoles = [];
	}
	
	private function initialize(p_core:core.Core):Void {
		_avaliableRoles = p_core.getRolesByRoleDef(_roleDef);
	}
	
	private function getEntities():Array<GameObject> {
		return _activeRoles;
	}
	
	public function tryToAddEntiry(entity:Entity):Void {
		var role:GameObject = _roleDef.createRole(entity);
		if (role != null) {
			if (_filter.check(entity)) {
				_activeRoles.push(role);
			}else {
				_filteredRoles.push(role);
			}
			entity.addRole(this);
		}
	}
	
	public function updateEntity(entity:Entity):Void {
		//TODO optimize
		var vo:GameObject = null;
		if (_filter.check(entity)) {
			for (i in 0..._filteredRoles.length) {
				if (_filteredRoles[i].entity == entity) {
					vo = _filteredRoles[i];
					_filteredRoles.slice(i, 1);
					break;
				}
			}
			if (vo == null)
				return;
				
			//for (i in 0..._acceptedEntities.length) {
				//if (_acceptedEntities[i].entity == entity) {
					////TODO error  - возможно проверять только в дебаг режме
				//}
			//}
			_activeRoles.push(vo);
			
		}else {
			for (i in 0..._activeRoles.length) {
				if (_activeRoles[i].entity == entity) {
					vo = _activeRoles[i];
					_activeRoles.splice(i, 1);
					break;
				}
			}
			if (vo == null)
				return;
			//for (i in 0..._filteredEntities.length) {
				//if (_filteredEntities[i].entity == entity) {
					//return;
				//}
			//}
			_filteredRoles.push(vo);
			
		}
	}

	public function removeEntity(entity:Entity):Void {
		for (i in 0..._activeRoles.length) {
			if (_activeRoles[i].entity == entity) {
				_activeRoles.splice(i, 1);
				entity.removeRole(this);
				return;
			}
		}
		for (i in 0..._filteredRoles.length) {
			if (_filteredRoles[i].entity == entity) {
				_filteredRoles.splice(i, 1);
				entity.removeRole(this);
				return;
			}
		}
	}
	public var forEntities(get_forEntities, null):Filter;
	public function get_forEntities():Filter {
		return _filter;
	}
	
	//public function withTags(tags:Array<Tag>):Role {
		//_filter.withTags(tags);
		//return this;
	//}
	//
	//public function noTags(tags:Array<Tag>):Role {
		//_filter.noTags(tags);
		//return this;
	//}
	
	//public function setRoleDef(roleDef:RoleDef):RoleSetup {
		//_roleDef = roleDef;
		//return this;
	//}
	
	public function setFilteredArray(array:Array<Dynamic>):Selector {
		_filteredRoles = cast array;
		return this;
	}
	
	//содержит сущности к-е прошли проверку по пропертям и по фильтрам
	private var _activeRoles:Array<GameObject>; 
	//содержит сущность к-е прошли проверку по пропертям, но не по фильтрам
	private var _avaliableRoles:Array<GameObject>;
	
	private var _filters:Array<FilterCondition>;
	
}