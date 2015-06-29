package examples.shooter.roles;
import cinema.properties.StringProperty;
import cinema.Role;
import cinema.Actor;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class ShooterRole extends PositionRole 
{
	
	// -- bulletType property --
	public var bulletType (get, set):String;
	private var _bulletTypeProperty:StringProperty;
	function get_bulletType():String { 
		return _bulletTypeProperty.value;	
	}
	function set_bulletType(value:String):String { 
		return _bulletTypeProperty.value = value;
	}
	
    public function new() 
    {
        super();
    }
	
	override function _readProperties():Void 
	{
		super._readProperties();
		_bulletTypeProperty = cast actor.getProperty("bulletType");
		
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor) && actor.hasProperty("bulletType");
	}
	
	override function _roleConstructor():Role 
	{
		return new ShooterRole();
	}
	
	override function _setName():Void 
	{
		name = "ShooterRole";
	}
}