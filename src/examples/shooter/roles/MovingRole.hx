package examples.shooter.roles;

import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.Role;
import cinema.roles.UpdatedRole;
import framework.common.roles.PositionRole;
import cinema.roles.IUpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MovingRole extends UpdatedRole
{
	static public inline var NAME = "MovingRole";
	
	// -- x property --
	public var x (get, set):Float;
	private var _xProperty:FloatProperty;
	private inline function get_x():Float { 
		return _xProperty.value;	
	}
	private inline function set_x(value:Float):Float { 
	   return _xProperty.value = value;
	}
	
	// -- y property --
	public var y (get, set):Float;
	private var _yProperty:FloatProperty;
	private inline function get_y():Float {
	   return _yProperty.value;
	}
	private inline function set_y(value:Float):Float {
	   return _yProperty.value = value;
	}
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
		_xProperty = cast(actor.getProperty("x"));
		_yProperty = cast actor.getProperty("y");
		_speedProperty = cast actor.getProperty("speed");
	}
	
	override public function update(dt:Float):Void {
		//TODO need direction
		y -= speed;
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("speed") && actor.hasProperty("x") && actor.hasProperty("y");
	}
	
	override function _roleConstructor():Role 
	{
		return new MovingRole();
	}
	
	override function get_roleName():String 
	{
		return NAME;
	}
}