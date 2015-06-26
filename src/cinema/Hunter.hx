package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Hunter
{
	public var roleClass(default, null):Class<Role>;
	public var roles(default, null):Array<Role>;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleClass:Class<Role> = null, p_roles:Array<Dynamic> = null) 
	{
		roleClass = p_roleClass;
		if (p_roles == null)
			roles = [];
		else
			roles = cast p_roles;
		if (roles.length >= 0) {
			//TODO error in should be empty
		}
		filter = new Filter();
	}
	
	
	// ---------- Role ----------
	@:allow(cinema.Story)
	private function _tryToAddRole(role:Role):Void {
		if (filter.check(role.actor)) {
			roles.push(role);
		}
	}
	
	@:allow(cinema.Story)
	private function _checkRoleAfterUpdate(p_role:Role):Void {
		if (filter.check(p_role.actor)) {
			if (roles.indexOf(p_role) == -1) 
				roles.push(p_role);
		}else {
			_removeRole(p_role);
		}
	}
	
	@:allow(cinema.Story)
	private function _removeRole(p_role:Role):Void {
		roles.remove(p_role);
	}
	
	// ---------- setup ----------
	public function setRoleDefClass(p_roleClass:Class<Role>):Hunter {
		roleClass = p_roleClass;
		return this;
	}
	
	public function setRolesArray(array:Array<Dynamic>):Hunter {
		//TODO либо запрещать менять после иницилазиации , либо как-то обрабатывать ситуацию когда к нему уже было обращение
		roles = cast array;
		return this;
	}
	
	public var filter(default, null):Filter;
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
}