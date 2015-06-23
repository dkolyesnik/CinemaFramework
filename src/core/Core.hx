package core;
import core.role.GameObject;
import core.role.GameObjectDef;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Core {
	//-static
	private var _started:Bool = false;
	public function new() {
		
	}

	public function start():Void {
		_started = true;
	}
	
	public function destroy():Void {
		//TODO destroy everithing
	}
	
	//TODO закрыть для всего кроме процессов
	public function allocateEntity():Entity {
		var entity:Entity = new Entity(this);
		_entitiesToAdd.push(entity);
		return entity;
	}

	public function removeEntity(entity:Entity):Void {
		
	}

	public function registerProcess(process:Process):Void {
		//TODO add process to list by process.priority
		if (_started) {
			//TODO error  сначала настройка проессов, затем работа
			return;
		}
		_processes.push(process);
		process.initialize(this);
	}

	//public function unregisterProcess(process:Process):Void {
		////TODO remove process to list by process.priority
		//if (_started) {
			////TODO error  сначала настройка проессов, затем работа
			//return;
		//}
		//_processes.splice(_processes.indexOf(process),1);
	//}
//
	//public function undate(dt:Float):Void {
		//for (entity in _entitiesToAdd) {
			//_registerEntity(entity);
		//}
		//
		//clearArray(_entitiesToAdd);
		//
		////TODO update all processec
		//for(process in _processes){
				//process.update(dt);
				//
		//}
		//
		//for (entity in _entitiesToRemove) {
			//_unregisterEntity(entity);
		//}
		//clearArray(_entitiesToRemove);
	//}
//
	//private function _registerEntity(entity:Entity):Void {
		//for (i in 0..._processes.length) {
			//_processes[i].tryToAddEntity(entity);
		//}
		//_entities.push(entity);
	//}
	//private function _unregisterEntity(entity:Entity):Void {
		//entity.destroy();	
		//_entities.splice(_entities.indexOf(entity), 1);
	//}
	//
	// Roles
	
	public function registerRoleDef(roleDef:GameObjectDef):Void {
		
	}
	
	//public function getRolesByRoleDef(roleDef:RoleDef):Array<Role> {
		//var result = _entitiesByRoleDef.get(roleDef.id);
		//if (result == null) {
			//result = _selectEntitiesByRoleDef(roleDef);
			//_entitiesByRoleDef.set(roleDef.id, result);
		//}
		//return result;
	//}
	
	//public function _selectEntitiesByRoleDef(roleDef:RoleDef):Array<Role> {
		//var array:Array<Role> = [];
		//for (entity in _entities) {
			//if (entity.hasProperties(roleDef.requiredProperties)) {
				//array.push(roleDef.createRole(entity));
			//}
		//}
		//return array;
	//}
	
	private var _roleSetupsByRoleDef:Map<String, Array<GameObject>> = new Map();
	//private var _entities:Array<Entity> = [];
	//private var _entitiesToAdd:Array<Entity> = [];
	//private var _entitiesToRemove:Array<Entity> = [];
	private var _processes:Array<Process> = [];
	
	
	//misc
	static inline function clearArray(array:Array<Entity>) {
		#if (cpp||php)
           array.splice(0,array.length);          
        #else
           untyped array.length = 0;
        #end
	}
}