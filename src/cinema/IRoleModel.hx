package cinema;

/**
 * @author Kolyesnik D.V.
 */
interface IRoleModel 
{
	var name:String;
	function checkRequirements(actor:Actor):Bool;
	
	function createRole(actor:Actor):Role;
	
}