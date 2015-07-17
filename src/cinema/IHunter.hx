package cinema;
import cinema.filters.Filter;

/**
 * @author Kolyesnik D.V.
 */
interface IHunter 
{
	var roleName(default, null):String;
	var filter(default, null):Filter;
	
	//function _tryToAddActor(actor:Actor):Void;
	//function _removeRole(p_role:T):Void;
	//function _checkRoleAfterUpdate(p_role:T):Void ;
}