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
		_charactersByRoleName = null;
		_rolesByName = null;
		_hasBegan = false;
	}
	
	// ---------- Scenarios ----------
	public function addEpisode(episode:Episode):Void {
		if (_hasBegan) {
			return;
		}
		_episodes.push(episode);
		episode._initialize(this);
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
		var characters:Array<Character>;
		var role:Role;
		var hero:Hero;
		for (roleName in _rolesByName.keys()) {
			role = _rolesByName.get(roleName);
			if (actor.hasProperties(role.requirements)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				characters = _charactersByRoleName.get(roleName);
				for (character in characters) {
					character._tryToAddHero(hero);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorRecievedProperty(actor:Actor):Void {
		var characters:Array<Character>;
		var role:Role;
		var hero:Hero;
		for (roleName in _rolesByName.keys()) {
			role = _rolesByName.get(roleName);
			if (actor.hasProperties(role.requirements) && !actor._hasHeroForRole(role)) {
				hero = role.createHero(actor);
				actor._addHero(hero);
				characters = _charactersByRoleName.get(roleName);
				for (character in characters) {
					character._tryToAddHero(hero);
				}
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorLostProperty(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var role:Role = _rolesByName.get(roleName);
		if (!hero.actor.hasProperties(role.requirements)) {
			var charactersArray = _charactersByRoleName.get(roleName);
			for (character in charactersArray) {
				character._removeHero(hero);
			}
		}
	}
	
	@:allow(cinema.Actor)
	private function _actorTagsModified(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var charactersArray = _charactersByRoleName.get(roleName);
		for (character in charactersArray) {
			character._checkHeroAfterUpdate(hero);
		}
	}
	
	@:allow(cinema.Actor)
	private function _removeHeroFromCharacters(hero:Hero):Void {
		var roleName = Type.getClassName(Type.getClass(hero.role));
		var charactersArray = _charactersByRoleName.get(roleName);
		for (character in charactersArray) {
			character._removeHero(hero);
		}
	}
		
	// ---------- Characters ----------
	@:allow(cinema.Episode)
	private function _addCharacter(character:Character):Void {
		var roleName:String = Type.getClassName(character.roleClass);
		var roleClass:Class<Role> = character.roleClass;
		var array = _charactersByRoleName.get(roleName);
		if (array == null) {
			array = [];
			_charactersByRoleName.set(roleName, array);
			_rolesByName.set(roleName, Type.createInstance(roleClass, []));
		}
		array.push(character);
		
	}
	
	// ---------- vars ----------
	private var _hasBegan:Bool = false;
	private var _episodes:Array<Episode> = [];
	private var _actors:Array<Actor> = [];
	private var _actorsToAdd:Array<Actor> = [];
	//TODO  заменить на ObjectMap
	private var _charactersByRoleName:Map<String, Array<Character>> = new Map();
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