package cinema;

/**
 * @author Kolyesnik D.V.
 */
interface IRoleModel 
{
	var roleName(get, null):String;
	function checkRequirements(actor:Actor):Bool;
	
	function createRole(actor:Actor):Role;
	
}