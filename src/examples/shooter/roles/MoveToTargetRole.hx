package examples.shooter.roles;

import cinema.Actor;
import cinema.properties.StringProperty;
import cinema.Role;
import examples.shooter.roleDefs.PositionRole;
import cinema.roles.IUpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoveToTargetRole extends PositionRole implements IUpdatedRole
{

	// -- target property --
	public var target (get, set):String;
	private var _targetProperty:StringProperty;
	function get_target():String { 
		return _targetProperty.value;	
	}
	function set_target(value:String):String { 
	   return _targetProperty.value = value;
	}
	
	public function new() 
	{
		super();
		
	}
	
	override function _initialize(p_actor:Actor):Role 
	{
		return super._initialize(p_actor);
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("speed");
	}
	
	override function _roleConstructor():Role 
	{
		return new PositionRole();
	}
	
	override function _setName():Void 
	{
		name = "Position";
	}
	
}