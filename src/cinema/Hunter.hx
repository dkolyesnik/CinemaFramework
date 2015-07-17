package cinema;
import cinema.filters.Filter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Hunter<T:Role>
{
	public var roleName(default, null):String;
	public var filter(default, null):Filter;
	
	private var _roles:Array<T>;
	
	
	
	//TODO можно добавить ещё динамический фильтр, который будет отфильтровывать объекты каждый раз перед использованием в сцене
	
	
	//TODO возможно стоит дать возможность задавать фильр чтобы давать возможность использовать фильтры повторно
	public function new(p_roleName:String ) 
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
			_addRole(cast actor._requestRole(roleName));
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
	
	private inline function _addRole(p_role:T):Void
	{
		_roles.push(p_role);
	}
	
	@:allow(cinema.Story)
	private inline function _removeRole(p_role:T):Void 
	{
		_roles.remove(p_role);
	}
	
	
	public function iterator():Iterator<T>
	{
		return _roles.iterator();
	}
	
	
}