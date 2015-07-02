package examples.shooter.roles;

import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.Role;
import examples.shooter.roles.PositionRole;
import cinema.roles.IUpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MovingRole extends PositionRole implements IUpdatedRole
{
	// -- speed property --
	public var speed (get, set):Float;
	private var _speedProperty:FloatProperty;
	function get_speed():Float { 
		return _speedProperty.value;	
	}
	function set_speed(value:Float):Float { 
	   return _speedProperty.value = value;
	}
	public function new() 
	{
		super();
		
	}
	
	override function _readProperties():Void 
	{
		super._readProperties();
		_speedProperty = cast actor.getProperty("speed");
	}
	
	public function update(dt:Float):Void {
		//TODO need direction
		y -= speed;
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("speed");
	}
	
	override function _roleConstructor():Role 
	{
		return new MovingRole();
	}
	
	override function _setName():Void 
	{
		name = "MovingRole";
	}
}