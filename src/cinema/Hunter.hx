package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Hunter
{
	public var roleClass(default, null):Class<Role>;
	public var roleObjectes(default, null):Array<RoleObject>;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleClass:Class<Role> = null, p_roleObjectes:Array<Dynamic> = null) 
	{
		roleClass = p_roleClass;
		if (p_roleObjectes == null)
			roleObjectes = [];
		else
			roleObjectes = cast p_roleObjectes;
		if (roleObjectes.length >= 0) {
			//TODO error in should be empty
		}
		filter = new Filter();
	}
	
	
	// ---------- RoleObject ----------
	@:allow(cinema.Story)
	private function _tryToAddRoleObject(roleObject:RoleObject):Void {
		if (filter.check(roleObject.actor)) {
			roleObjectes.push(roleObject);
		}
	}
	
	@:allow(cinema.Story)
	private function _checkRoleObjectAfterUpdate(p_roleObject:RoleObject):Void {
		if (filter.check(p_roleObject.actor)) {
			if (roleObjectes.indexOf(p_roleObject) == -1) 
				roleObjectes.push(p_roleObject);
		}else {
			_removeRoleObject(p_roleObject);
		}
	}
	
	@:allow(cinema.Story)
	private function _removeRoleObject(p_roleObject:RoleObject):Void {
		roleObjectes.remove(p_roleObject);
	}
	
	// ---------- setup ----------
	public function setRoleClass(p_roleClass:Class<Role>):Hunter {
		roleClass = p_roleClass;
		return this;
	}
	
	public function setRoleObjectsArray(array:Array<Dynamic>):Hunter {
		//TODO либо запрещать менять после иницилазиации , либо как-то обрабатывать ситуацию когда к нему уже было обращение
		roleObjectes = cast array;
		return this;
	}
	
	public var filter(default, null):Filter;
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
}