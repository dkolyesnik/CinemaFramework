package cinema;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Story
{

	/*
	 * идеии на будущее
	 * добавить пулы под актеров 
	 * добавить инфу для дебага, количество сущностей, пиковое количество суностей 
	 * дополнительные проверки, возможно какое-то логирование 
	 * 
	 * добавить базовых героев для частых случаем PositionRole , SpatialRole и тд
	 * 
	 * добавить вложенных героев...
	 */
	
	public function new() 
	{
		
	}
	public function begin():Void {
		_hasBegan = true;
	}
	
	public function update(dt:Float):Void {
		//TODO better name and checking if hasBegan
		for (actor in _actorsToAdd) {
			_addActor(actor);
		}
		clearArray(_actorsToAdd);
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
		for (actor in _actors) {
			actor._destroy();
		}
		_episodes = null;
		_actors = null;
		_actorsToAdd = null;
		_huntersByRoleName = null;
		_roleModelsByName = null;
		_hasBegan = false;
	}
	
	// ---------- Episodes ----------
	public function addEpisode(episode:Episode):Void {
		if (_hasBegan) {
			return;
		}
		_episodes.push(episode);
		episode._initialize(this);
	}
	
	// ---------- Actors ----------
	public function createActor(p_name:String = ""):Actor {
		if (p_name == "") {
			p_name = _generateName();
		}
		var actor = new Actor(p_name);
		_actorsToAdd.push(actor);
		return actor;
	}
	
	public function removeActor(actor:Actor):Void {
		_actors.remove(actor.name);
		actor._destroy();
	}
	
	//TODO переделать так, тобы имя генероилось не только из цифр
	private function _generateName():String {
		return "@" + Std.string(++_actorNameCount);
	}
	
	private function _addActor(actor:Actor):Void {
		//TODO = optimize
		actor._initialize(this);
		_actors.set(actor.name, actor);
		var huntersArray:Array<Hunter>;
		var role:Role;
		for (roleModel in _roleModelsByName) {
			if (roleModel.checkRequirements(actor)) {
				role = roleModel.createRole(actor);
				actor._addRole(role);
				huntersArray = _huntersByRoleName.get(roleModel.name);
				for (hunter in huntersArray) {
					hunter._tryToAddRole(role);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorRecievedProperty(actor:Actor):Void {
		var hunters:Array<Hunter>;
		var role:Role;
		for (roleModel in _roleModelsByName) {
			if (roleModel.checkRequirements(actor) && !actor._hasRole(roleModel.name)) {
				role = roleModel.createRole(actor);
				actor._addRole(role);
				hunters = _huntersByRoleName.get(roleModel.name);
				for (hunter in hunters) {
					hunter._tryToAddRole(role);
				}
			}
		}
	}
	
		
	@:allow(cinema.Actor)
	private function _actorLostProperty(role:Role):Void {
		if (!role.checkRequirements(role.actor)) {
			var huntersArray = _huntersByRoleName.get(role.name);
			for (hunter in huntersArray) {
				hunter._removeRole(role);
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorTagsModified(role:Role):Void {
		var huntersArray = _huntersByRoleName.get(role.name);
		for (hunter in huntersArray) {
			hunter._checkRoleAfterUpdate(role);
		}
	}
	
	@:allow(cinema.Actor)
	private function _removeRoleFromHunters(role:Role):Void {
		var huntersArray = _huntersByRoleName.get(role.name);
		for (hunter in huntersArray) {
			hunter._removeRole(role);
		}
	}
		
	// ---------- Hunters & RoleDefs ----------
	@:allow(cinema.Episode)
	private function _addHunter(hunter:Hunter):Void {
		var roleModel = _getRoleByClass(hunter.roleClass);
		var array = _huntersByRoleName.get(roleModel.name);
		if (array == null) {
			array = [];
			_huntersByRoleName.set(roleModel.name, array);
		}
		array.push(hunter);
		
	}
	
	@:allow(cinema.Episode)
	private function _getRoleByClass(roleClass:Class<Role>):Role {
		var tempRole:Role = Type.createInstance(roleClass, []);
		var roleName:String = tempRole.name;
		if (_roleModelsByName.exists(roleName)) {
			return _roleModelsByName[roleName];
		}else {
			_roleModelsByName.set(roleName, tempRole);
			return tempRole;
		}
		
	}
	
	
	
	// ---------- vars ----------
	private var _hasBegan:Bool = false;
	private var _episodes:Array<Episode> = [];
	private var _actors:Map<String, Actor> = new Map();
	private var _actorsToAdd:Array<Actor> = [];
	//TODO  заменить на ObjectMap
	private var _huntersByRoleName:Map<String, Array<Hunter>> = new Map();
	private var _roleModelsByName:Map<String, Role> = new Map();
	
	private var _actorNameCount:Int = 0;
	
	//misc
	static inline function clearArray(array:Array<Actor>) {
		#if (cpp||php)
           array.splice(0,array.length);          
        #else
           untyped array.length = 0;
        #end
	}
	
}