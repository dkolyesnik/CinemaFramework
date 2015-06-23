package core;
import cinema.filters.Filter;
import core.role.GameObjectDef;
import core.role.Selector;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class Process
{
	
	public function new() {
		_roleSetupArray = [];
	}
	
	public function initialize(core:Core):Void {
		_core = core;
		for (role in _roleSetupArray) {
			//_core.getRolesByRoleDef(
		}
	}
	
	//public function tryToAddEntity(entity:Entity):Void {
		////TODO filter
		//for (i in 0..._roleSetupArray.length) {
			//_roleSetupArray[i].tryToAddEntiry(entity);
		//}
	//}
	//
	//
	
	//
	//public function update(dt:Float):Void {
		//
	//}
	//
	//- for roles
	private function _createRoleSetup(roleDef:GameObjectDef):Selector {
		var roleSetup = new Selector(roleDef);
		_roleSetupArray.push(roleSetup);
		return roleSetup;
	}
	
	private var _roleSetupArray:Array<Selector>;
	private var _core:Core;
}