/**
 * ...
 * @author Kolyesnik D.V.
 */
package examples.shooter.roles;
import cinema.properties.IntProperty;
import cinema.properties.StringProperty;
import cinema.Role;
import examples.shooter.roles.PositionRole;
import openfl.display.Sprite;

class ImageRole extends Role 
{
	public var spatial2dRole:Spatial2dRole;
	public var sizeRole:SizeRole;
	
	// -- layer property --
	public var layer (get, set):Int;
	private var _layerProperty:IntProperty;
	function get_layer():Int { 
		return _layerProperty.value;	
	}
	function set_layer(value:Int):Int { 
		return _layerProperty.value = value;
	}
	
	// -- imageName property --
	public var imageName (get, set):String;
	private var _imageNameProperty:StringProperty;
	function get_imageName():String { 
		return _imageNameProperty.value;	
	}
	function set_imageName(value:String):String { 
		return _imageNameProperty.value = value;
	}
	
    public function new() 
    {
        
    }
	override function _initialize(p_actor:Actor):Role 
	{
		super._initialize(p_actor);
		
		return this;
	}
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return super.checkRequirements(actor);
	}
	
	override function _roleConstructor():Role 
	{
		return new ImageRole();
	}
	
	override function _setName():Void 
	{
		name = "ImageRole";
	}
}