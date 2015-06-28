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
	
	public function setFactory(p_factory:IActorsFactory):IActorsFactory {
		if (_actorsFactory != null) {
			_actorsFactory.removeStory();
		}
		_actorsFactory = p_factory;
		_actorsFactory.setStory(this);
		return p_factory;
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
			if (episode.preUpdate()) {
				episode.update(dt);
				episode.postUpdate();
			}
			removeMarkedActors();
			modifyMarkedTagActors();
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
		_actorsToUpdateTagsByName = null;
		_actorsToUpdateTags = null;
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
	public function createByFactory(type:String, name:String = ""):Actor {
		if (_actorsFactory == null) {
			//TODO error
			trace("factory is not set");
			return null;
		}
		return _actorsFactory.create(type, name);
	}
	
	public function createActor(p_name:String = ""):Actor {
		if (p_name == "") {
			p_name = _generateName();
		}
		var actor = new Actor(p_name);
		_actorsToAdd.push(actor);
		return actor;
	}
	
	public function findActor(p_name:String):Actor {
		if (_actors.exists(p_name)) {
			return _actors[p_name];
		}
		return null;
	}
	
	public function removeActor(p_actor:Actor):Void {
		_actorsToRemove.push(p_actor);
		
	}
	
	public function markAsTagModified(actor:Actor):Void {
		if (_actorsToUpdateTagsByName.exists(actor.name)) {
			return;
		}
		_actorsToUpdateTagsByName[actor.name] = actor;
		_actorsToUpdateTags.push(actor);
	}
	
	/**
	 * Call _actorTagsModified for every marked actor
	 * updates the hunters
	 */
	public function modifyMarkedTagActors():Void {
		for (actor in _actorsToUpdateTags) {
			_actorTagsModified(actor);
			_actorsToUpdateTagsByName.remove(actor.name);
		}
		clearArray(_actorsToUpdateTags);
		
	}
	
	/**
	 *  remove all marked to remove actors
	 */
	public function removeMarkedActors():Void {
		for (actor in _actorsToRemove) {
			_actors.remove(actor.name);
			_actorsToAdd.remove(actor);
			_actorsToUpdateTags.remove(actor);
			_actorsToUpdateTagsByName.remove(actor.name);
			actor._onRemove();	
		}
		clearArray(_actorsToRemove);
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
	private function _actorTagsModified(actor:Actor):Void {
		for (role in actor._getRoles()) {
			var huntersArray = _huntersByRoleName.get(role.name);
			for (hunter in huntersArray) {
				hunter._checkRoleAfterUpdate(role);
			}
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
		var roleModel = _getRoleModelByClass(hunter.roleClass);
		var array = _huntersByRoleName.get(roleModel.name);
		if (array == null) {
			array = [];
			_huntersByRoleName.set(roleModel.name, array);
		}
		array.push(hunter);
		
	}
	
	@:allow(cinema.Episode)
	private function _getRoleModelByClass(roleClass:Class<Role>):IRoleModel {
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
	// actors
	private var _actorsFactory:IActorsFactory;
	private var _actors:Map<String, Actor> = new Map();
	private var _actorsToAdd:Array<Actor> = [];
	private var _actorsToRemove:Array<Actor> = [];
	private var _actorsToUpdateTags:Array<Actor> = [];
	private var _actorsToUpdateTagsByName:Map<String, Actor> = new Map();
	//
	//TODO  заменить на ObjectMap
	private var _huntersByRoleName:Map<String, Array<Hunter>> = new Map();
	private var _roleModelsByName:Map<String, IRoleModel> = new Map();
	
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