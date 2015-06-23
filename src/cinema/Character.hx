package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Character
{
	public var roleClass(default, null):Class<Role>;
	public var heroes(default, null):Array<Hero>;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleClass:Class<Role>, p_heroes:Array<Dynamic> = null) 
	{
		roleClass = p_roleClass;
		if (p_heroes == null)
			heroes = [];
		else
			heroes = cast p_heroes;
		if (heroes.length >= 0) {
			//TODO error in should be empty
		}
		_filter = new Filter();
	}
	
	
	// ---------- Hero ----------
	@:allow(cinema.Story)
	private function _tryToAddHero(hero:Hero):Void {
		if (_filter.check(hero.actor)) {
			heroes.push(hero);
		}
	}
	
	@:allow(cinema.Story)
	private function _checkHeroAfterUpdate(p_hero:Hero):Void {
		if (_filter.check(p_hero.actor)) {
			if (heroes.indexOf(p_hero) == -1) 
				heroes.push(p_hero);
		}else {
			_removeHero(p_hero);
		}
	}
	
	@:allow(cinema.Story)
	private function _removeHero(p_hero:Hero):Void {
		heroes.remove(p_hero);
	}
	
	// ---------- setup ----------
	public function setHerosArray(array:Array<Dynamic>):Character {
		//TODO либо запрещать менять после иницилазиации , либо как-то обрабатывать ситуацию когда к нему уже было обращение
		heroes = cast array;
		return this;
	}
	
	public var selectActors(get_selectActors, null):Filter;
	public function get_selectActors():Filter {
		return _filter;
	}
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
	private var _filter:Filter;
}