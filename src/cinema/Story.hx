package cinema;
import cinema.IActorsFactory;
import cinema.IRoleModel;
import haxe.ds.ObjectMap;
import openfl.errors.Error;

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
	
	public function new() {	}
	
	public function setFactory(p_factory:IActorsFactory):IActorsFactory 
	{
		if (_actorsFactory != null) 
		{
			_actorsFactory.removeStory();
		}
		_actorsFactory = p_factory;
		_actorsFactory.setStory(this);
		return p_factory;
	}
	
	public function begin():Void
	{
		_hasBegan = true;
	}
	
	public function update(dt:Float):Void 
	{
		//TODO better name and checking if hasBegan
		for (actor in _actorsToAdd) 
		{
			_addActor(actor);
		}
		
		clearArray(_actorsToAdd);
		
		for (episode in _episodes) 
		{
			if (episode.preUpdate()) 
			{
				episode.update(dt);
				episode.postUpdate();
			}
			updateActors();
		}
	}
	
	public function end():Void 
	{
		_hasBegan = false;
		//TODO удаление сего 
		for (episode in _episodes) 
		{
			episode._destroy();
		}
		
		for (actor in _actors) 
		{
			actor._destroy();
		}
		_episodes = null;
		_actors = null;
		_actorsToAdd = null;
		_actorsToUpdateTagsByName = null;
		_actorsToUpdateTags = null;
		_actorsToRemoveByName = null;
		_actorsToRemove = null;
		_huntersByRoleName = null;
		_roleModelsByName = null;
		_hasBegan = false;
	}
	
	// ---------- Episodes ----------
	public function addEpisode(episode:Episode):Void 
	{
		if (_hasBegan) 
		{
			return;
		}
		_episodes.push(episode);
		episode._initialize(this);
	}
	
	//--------------------------------------------------------------
	//   Actors
	//--------------------------------------------------------------

	public function createByFactory(type:String, name:String = ""):Actor 
	{
		if (_actorsFactory == null) 
		{
			//TODO error
			trace("factory is not set");
			return null;
		}
		return _actorsFactory.create(type, name);
	}
	
	public function createActor(p_name:String = ""):Actor 
	{
		if (p_name == "") 
		{
			p_name = _generateName();
		}
		var actor = new Actor(p_name);
		_actorsToAdd.push(actor);
		return actor;
	}
	
	public function findActor(p_name:String):Actor
	{
		if (_actors.exists(p_name)) 
		{
			return _actors[p_name];
		}
		return null;
	}
	
	public function markAsNeedToBeRemoved(p_actor:Actor):Void 
	{
		if (!_actorsToRemoveByName.exists(p_actor.name))
		{
			_actorsToRemoveByName[p_actor.name] = p_actor;
			_actorsToRemove.push(p_actor);
		}
	}
	
	public function markAsTagModified(actor:Actor):Void 
	{
		if (_actorsToUpdateTagsByName.exists(actor.name)) 
		{
			return;
		}
		_actorsToUpdateTagsByName[actor.name] = actor;
		_actorsToUpdateTags.push(actor);
	}
	
	public function markAsPropertyAdded(actor:Actor)
	{
		if (_actorsToUpdateOnPropertyAddedByName.exists(actor.name))
		{
			return;
		}
		_actorsToUpdateOnPropertyAddedByName[actor.name] = actor;
		_actorsToUpdateOnPropertyAdded.push(actor);
	}
	
	public function markAsPropertyLost(actor:Actor)
	{
		if (_actorsToUpdateOnPropertyLostByName.exists(actor.name))
		{
			return;
		}
		_actorsToUpdateOnPropertyLostByName.exists(actor.name);
		_actorsToUpdateOnPropertyLost.push(actor);
	}
	
	/**
	 * Remove all marked to remove actors, update roles and hunters for
	 * actros who changed tags or properties
	 * ( возмодно стоит и добавлять актеров тут, но тогда они могут не пройти весь путь по эпизодам.)
	 */
	public function updateActors()
	{
		removeMarkedActors();
		modifyMarkedPropertyLost();
		modifyMarkedPropertyAdded();
		modifyMarkedTagActors();
	}
	
	//--------------------------------------------------------------
	//   Actors private
	//--------------------------------------------------------------
	
	/**
	 * Call _actorLostProperty for every marked actor
	 * updates the hunters
	 */
	private function modifyMarkedPropertyLost()
	{
		for (actor in _actorsToUpdateOnPropertyLost)
		{
			_actorLostProperty(actor);
			_actorsToUpdateOnPropertyLostByName.remove(actor.name);
		}
		clearArray(_actorsToUpdateOnPropertyLost);
	}
	
	/**
	 * Call _actorRecievedProperty for every marked actor
	 * updates the hunters
	 */
	private function modifyMarkedPropertyAdded()
	{
		for (actor in _actorsToUpdateOnPropertyAdded)
		{
			_actorRecievedProperty(actor);
			_actorsToUpdateOnPropertyAddedByName.remove(actor.name);
		}
		clearArray(_actorsToUpdateOnPropertyAdded);
	}
	
	/**
	 * Call _actorTagsModified for every marked actor
	 * updates the hunters
	 */
	private function modifyMarkedTagActors():Void
	{
		for (actor in _actorsToUpdateTags) 
		{
			_actorTagsModified(actor);
			_actorsToUpdateTagsByName.remove(actor.name);
		}
		clearArray(_actorsToUpdateTags);
		
	}
	
	/**
	 *  remove all marked to remove actors
	 */
	private function removeMarkedActors():Void 
	{
		for (actor in _actorsToRemove)
		{
			_actors.remove(actor.name);
			_actorsToAdd.remove(actor);
			_actorsToUpdateTags.remove(actor);
			_actorsToUpdateTagsByName.remove(actor.name);
			_actorsToRemoveByName.remove(actor.name);
			actor._onRemove();	
		}
		
		clearArray(_actorsToRemove);
	}
	
	//TODO переделать так, тобы имя генероилось не только из цифр
	private function _generateName():String 
	{
		return "@" + Std.string(++_actorNameCount);
	}
	
	private function _addActor(actor:Actor):Void
	{
		//TODO = optimize
		actor._initialize(this);
		_actors.set(actor.name, actor);
		var huntersArray:Array<Hunter<Role>>;
		for (roleModel in _roleModelsByName) 
		{
			if (roleModel.checkRequirements(actor)) 
			{
				huntersArray = _huntersByRoleName.get(roleModel.roleName);
				for (hunter in huntersArray)
				{
					hunter._tryToAddActor(actor);
				}
			}
		}
	}

	
	@:allow(cinema.Actor)
	private function _actorRecievedProperty(actor:Actor):Void 
	{
		var hunters:Array<Hunter<Role>>;
		for (roleModel in _roleModelsByName) 
		{
			if (roleModel.checkRequirements(actor) && !actor._hasRole(roleModel.roleName)) 
			{
				hunters = _huntersByRoleName.get(roleModel.roleName);
				for (hunter in hunters) 
				{
					hunter._tryToAddActor(actor);
				}
			}
		}
	}
	
		
	@:allow(cinema.Actor)
	private function _actorLostProperty(actor:Actor):Void 
	{
		for (role in actor._getRoles()) 
		{
			if (!role.checkRequirements(role.actor))
			{
				var huntersArray = _huntersByRoleName.get(role.roleName);
				for (hunter in huntersArray)
				{
					hunter._removeRole(role);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorTagsModified(actor:Actor):Void 
	{
		for (role in actor._getRoles()) 
		{
			var huntersArray = _huntersByRoleName.get(role.roleName);
			for (hunter in huntersArray) 
			{
				hunter._checkRoleAfterUpdate(role);
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _removeRoleFromHunters(role:Role):Void 
	{
		var huntersArray = _huntersByRoleName.get(role.roleName);
		for (hunter in huntersArray) 
		{
			hunter._removeRole(role);
		}
	}
		
	//--------------------------------------------------------------
	//   Hunters
	//--------------------------------------------------------------

	@:allow(cinema.Episode)
	private function _addHunter(hunter:Hunter<Role>):Void 
	{
		var roleModel = getRoleModel(hunter.roleName);
		var array = _huntersByRoleName.get(roleModel.roleName);
		if (array == null) 
		{
			array = [];
			_huntersByRoleName.set(roleModel.roleName, array);
		}
		array.push(hunter);
		
	}
	
	//--------------------------------------------------------------
	//   Roles
	//--------------------------------------------------------------
	
	public function registerRoleModel(roleModel:IRoleModel)
	{
		if (_roleModelsByName.exists(roleModel.roleName))
		{
			//TODO warning
		}
		else
		{
			_roleModelsByName[roleModel.roleName] = roleModel;
		}
	}
	
	public function getRoleModel(roleName:String):IRoleModel 
	{
		if (_roleModelsByName.exists(roleName)) 
		{
			return _roleModelsByName[roleName];
		}
		else 
		{
			//TODO error
			throw new Error("Role model " + roleName+ " is not registered");
			trace("Role model " + roleName+ " is not registered");
			return null;
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
	private var _actorsToRemoveByName:Map<String, Actor> = new Map();
	
	private var _actorsToUpdateTags:Array<Actor> = [];
	private var _actorsToUpdateTagsByName:Map<String, Actor> = new Map();
	
	private var _actorsToUpdateOnPropertyLost:Array<Actor> = [];
	private var _actorsToUpdateOnPropertyLostByName:Map<String, Actor> = new Map();
	
	private var _actorsToUpdateOnPropertyAdded:Array<Actor> = [];
	private var _actorsToUpdateOnPropertyAddedByName:Map<String, Actor> = new Map();
	
	//
	//TODO  заменить на ObjectMap
	private var _huntersByRoleName:Map<String, Array<Hunter<Role>>> = new Map();
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