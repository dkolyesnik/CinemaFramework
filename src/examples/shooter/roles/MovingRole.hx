package examples.shooter.roleDefs;

import cinema.Actor;
import examples.test1.PositionRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MovingRole extends PositionRole
{
	// -- speed property --
	public var speed (get, set):Int;
	private var _speedProperty:IntProperty;
	function get_speed():Int { 
		return _speedProperty.value;	
	}
	function set_speed(value:Int):Int { 
	   return _speedProperty.value = value;
	}
	public function new() 
	{
		super();
		
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