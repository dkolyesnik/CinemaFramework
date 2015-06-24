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
	 * добавить базовых героев для частых случаем PositionHero , SpatialHero и тд
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
		_rolesByName = null;
		_hasBegan = false;
	}
	
	// ---------- Episodes ----------
	@:allow(cinema.Episode)
	private function _addEpisode(episode:Episode):Void {
		if (_hasBegan) {
			return;
		}
		_episodes.push(episode);
	}
	
	// ---------- Actors ----------
	//TODO rename crateActor
	public function hireActor():Actor {
		var actor = new Actor();
		_actorsToAdd.push(actor);
		return actor;
	}
	
	public function removeActor(actor:Actor):Void {
		if (_actors.remove(actor)) {
			actor._destroy();
		}
	}
	
	private function _addActor(actor:Actor):Void {
		//TODO = optimize
		actor._initialize(this);
		var hunters:Array<Hunter>;
		var role:Role;
		var hero:Hero;
		for (roleName in _rolesByName.keys()) {
			role = _rolesByName.get(roleName);
			if (actor.hasProperties(role.requirements)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				hunters = _huntersByRoleName.get(roleName);
				for (hunter in hunters) {
					hunter._tryToAddHero(hero);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorRecievedProperty(actor:Actor):Void {
		var hunters:Array<Hunter>;
		var role:Role;
		var hero:Hero;
		for (roleName in _rolesByName.keys()) {
			role = _rolesByName.get(roleName);
			if (actor.hasProperties(role.requirements) && !actor._hasHeroForRole(role)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				hunters = _huntersByRoleName.get(roleName);
				for (hunter in hunters) {
					hunter._tryToAddHero(hero);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorLostProperty(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var role:Role = _rolesByName.get(roleName);
		if (!hero.actor.hasProperties(role.requirements)) {
			var huntersArray = _huntersByRoleName.get(roleName);
			for (hunter in huntersArray) {
				hunter._removeHero(hero);
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorTagsModified(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var huntersArray = _huntersByRoleName.get(roleName);
		for (hunter in huntersArray) {
			hunter._checkHeroAfterUpdate(hero);
		}
	}
	
	@:allow(cinema.Actor)
	private function _removeHeroFromHunters(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var huntersArray = _huntersByRoleName.get(roleName);
		for (hunter in huntersArray) {
			hunter._removeHero(hero);
		}
	}
		
	// ---------- Hunters ----------
	@:allow(cinema.Episode)
	private function _addHunter(hunter:Hunter):Void {
		var roleName:String = Type.getClassName(hunter.roleClass);
		var roleClass:Class<Role> = hunter.roleClass;
		var array = _huntersByRoleName.get(roleName);
		if (array == null) {
			array = [];
			_huntersByRoleName.set(roleName, array);
			_rolesByName.set(roleName, Type.createInstance(roleClass, []));
		}
		array.push(hunter);
		
	}
	
	// ---------- vars ----------
	private var _hasBegan:Bool = false;
	private var _episodes:Array<Episode> = [];
	private var _actors:Array<Actor> = [];
	private var _actorsToAdd:Array<Actor> = [];
	//TODO  заменить на ObjectMap
	private var _huntersByRoleName:Map<String, Array<Hunter>> = new Map();
	private var _rolesByName:Map<String, Role> = new Map();
	
	//misc
	static inline function clearArray(array:Array<Actor>) {
		#if (cpp||php)
           array.splice(0,array.length);          
        #else
           untyped array.length = 0;
        #end
	}
	
}