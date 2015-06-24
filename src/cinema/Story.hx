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
		_huntersByRole = null;
		_rolesByClassName = null;
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
	public function createActor():Actor {
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
		var huntersArray:Array<Hunter>;
		var hero:Hero;
		for (role in _rolesByClassName) {
			if (actor.hasProperties(role.requirements)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				huntersArray = _huntersByRole.get(role);
				for (hunter in huntersArray) {
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
		for (role in _rolesByClassName) {
			if (actor.hasProperties(role.requirements) && !actor._hasHeroForRole(role)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				hunters = _huntersByRole.get(role);
				for (hunter in hunters) {
					hunter._tryToAddHero(hero);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorLostProperty(hero:Hero):Void {
		if (!hero.actor.hasProperties(hero.role.requirements)) {
			var huntersArray = _huntersByRole.get(hero.role);
			for (hunter in huntersArray) {
				hunter._removeHero(hero);
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorTagsModified(hero:Hero):Void {
		var huntersArray = _huntersByRole.get(hero.role);
		for (hunter in huntersArray) {
			hunter._checkHeroAfterUpdate(hero);
		}
	}
	
	@:allow(cinema.Actor)
	private function _removeHeroFromHunters(hero:Hero):Void {
		var huntersArray = _huntersByRole.get(hero.role);
		for (hunter in huntersArray) {
			hunter._removeHero(hero);
		}
	}
		
	// ---------- Hunters & Roles ----------
	@:allow(cinema.Episode)
	private function _addHunter(hunter:Hunter):Void {
		var role = _getRoleByClass(hunter.roleClass);
		var array = _huntersByRole.get(role);
		if (array == null) {
			array = [];
			_huntersByRole.set(role, array);
		}
		array.push(hunter);
		
	}
	
	@:allow(cinema.Episode)
	private function _getRoleByClass(roleClass:Class<Role>):Role {
		var roleName:String = Type.getClassName(roleClass);
		if (_rolesByClassName.exists(roleName)) {
			return _rolesByClassName[roleName];
		}else {
			var role = Type.createInstance(roleClass, []);
			_rolesByClassName.set(roleName, role);
			return role;
		}
		
	}
	
	// ---------- vars ----------
	private var _hasBegan:Bool = false;
	private var _episodes:Array<Episode> = [];
	private var _actors:Array<Actor> = [];
	private var _actorsToAdd:Array<Actor> = [];
	//TODO  заменить на ObjectMap
	private var _huntersByRole:Map<Role, Array<Hunter>> = new Map();
	private var _rolesByClassName:Map<String, Role> = new Map();
	
	//misc
	static inline function clearArray(array:Array<Actor>) {
		#if (cpp||php)
           array.splice(0,array.length);          
        #else
           untyped array.length = 0;
        #end
	}
	
}