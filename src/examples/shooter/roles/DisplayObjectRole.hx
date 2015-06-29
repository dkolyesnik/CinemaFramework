/**
 * Created by ִלטענטי on 28.06.2015.
 */
package examples.shooter.roles;
import cinema.properties.IntProperty;
import cinema.Role;
import cinema.Actor;
import examples.shooter.properties.DisplayObjectProperty;
import framework.roles.UpdatedRole;
import openfl.display.DisplayObject;
class DisplayObjectRole extends UpdatedRole {

	public var position:PositionRole;
	public var size:SizeRole;
	
	// -- displayObject property --
	public var displayObject (get, set):DisplayObject;
	private var _displayObjectProperty:DisplayObjectProperty;
	function get_displayObject():DisplayObject { 
		return _displayObjectProperty.value;	
	}
	function set_displayObject(value:DisplayObject):DisplayObject { 
		return _displayObjectProperty.value = value;
	}
	
	// -- layer property --
	public var layer (get, set):Int;
	private var _layerProperty:IntProperty;
	function get_layer():Int { 
		return _layerProperty.value;	
	}
	function set_layer(value:Int):Int { 
		return _layerProperty.value = value;
	}
	
    public function new() {
		super();
    }
  
	override public function update(dt:Float):Void 
	{
		var img = displayObject;
		img.x = position.x;
		img.y = position.y;
		img.width = size.width;
		img.height = size.height;
	}
	
	override function _readProperties():Void 
	{
		_displayObjectProperty = cast actor.getProperty("displayObject");
		_layerProperty = cast actor.getProperty("layer");
		position = cast new PositionRole()._initialize(actor);
		size = cast new SizeRole()._initialize(actor);
		
	}
	
	// ----- Model ------
	override public function checkRequirements(actor:Actor):Bool 
	{
		return actor.hasProperty("x") && actor.hasProperty("y") 
			&& actor.hasProperty("width") && actor.hasProperty("height") 
			&& actor.hasProperty("layer") && actor.hasProperty("displayObject");
	}
	
	override function _roleConstructor():Role 
	{
		return new DisplayObjectRole();
	}
	
	override function _setName():Void 
	{
		name = "DisplayObjectRole";
	}
}

