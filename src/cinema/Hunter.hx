package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Hunter
{
	public var roleDefClass(default, null):Class<RoleDef>;
	public var rolees(default, null):Array<Role>;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleDefClass:Class<RoleDef> = null, p_rolees:Array<Dynamic> = null) 
	{
		roleDefClass = p_roleDefClass;
		if (p_rolees == null)
			rolees = [];
		else
			rolees = cast p_rolees;
		if (rolees.length >= 0) {
			//TODO error in should be empty
		}
		filter = new Filter();
	}
	
	
	// ---------- Role ----------
	@:allow(cinema.Story)
	private function _tryToAddRole(role:Role):Void {
		if (filter.check(role.actor)) {
			rolees.push(role);
		}
	}
	
	@:allow(cinema.Story)
	private function _checkRoleAfterUpdate(p_role:Role):Void {
		if (filter.check(p_role.actor)) {
			if (rolees.indexOf(p_role) == -1) 
				rolees.push(p_role);
		}else {
			_removeRole(p_role);
		}
	}
	
	@:allow(cinema.Story)
	private function _removeRole(p_role:Role):Void {
		rolees.remove(p_role);
	}
	
	// ---------- setup ----------
	public function setRoleDefClass(p_roleDefClass:Class<RoleDef>):Hunter {
		roleDefClass = p_roleDefClass;
		return this;
	}
	
	public function setRolesArray(array:Array<Dynamic>):Hunter {
		//TODO либо запрещать менять после иницилазиации , либо как-то обрабатывать ситуацию когда к нему уже было обращение
		rolees = cast array;
		return this;
	}
	
	public var filter(default, null):Filter;
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
}