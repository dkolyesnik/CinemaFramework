package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
@:generic
class Hunter<T:Role> 
{
	public var roleName(default, null):String;
	private var _roles:Array<T>;
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	public var filter(default, null):Filter;
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleName:String = null) 
	{
		roleName = p_roleName;
		_roles = [];
			
		if (_roles.length >= 0) {
			//TODO error it should be empty
		}
		filter = new Filter();
	}
	
	
	// ---------- Role ----------
	@:allow(cinema.Story)
	private function _tryToAddActor(actor:Actor):Void 
	{
		if (filter.check(actor)) 
		{
			_roles.push(actor.requestRole(roleName));
		}
	}
	
	@:allow(cinema.Story)
	private function _checkRoleAfterUpdate(p_role:T):Void 
	{
		if (filter.check(p_role.actor)) 
		{
			if (_roles.indexOf(p_role) == -1) 
				_roles.push(p_role);
		}
		else 
		{
			_removeRole(p_role);
		}
	}
	
	@:allow(cinema.Story)
	private function _removeRole(p_role:T):Void 
	{
		_roles.remove(p_role);
	}
	
	
	public function inerator():Iterator<T>
	{
		return _roles.iterator();
	}
	
	
}