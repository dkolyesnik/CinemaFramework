package cinema;
import cinema.properties.AbstractProperty;
import cinema.properties.IntProperty;
import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Actor
{
	public var name(default, null):String;
	public function new(p_name:String) 
	{
		name = p_name;
	} 
	
	@:allow(cinema.Story)
	private function _initialize(story:Story):Void {
		_story = story;
	}
	
	/**
	 * called when removed from story
	 */
	@:allow(cinema.Story)
	private function _onRemove():Void {
		for (role in _roles) {
			_story._removeRoleFromHunters(role);
		}
		_destroy();
	}
	
	/**
	  Called when story is ended
	**/
	@:allow(cinema.Story)
	private function _destroy():Void {
		_story = null;
		_roles = null;
		_tags = null;
		_removeAllPropertiesOnDestroy();
	}
	
	// ---------- Properties ----------
	//public function addProperty(propertyName:String, ?property:Property , ?intValue:Int, ?floatValue:Float, ?stringValue:String):Void {
		//if (property == null && intValue == null && floatValue == null && stringValue == null){
			////TODO error
			//trace("ERRoleR1");
			//return;
		//}
		//if (property == null) {
			//if (intValue != null)
				//property = new IntProperty(intValue);
		//}	
		//
		//else if (property != null) {
			//if(_properties[propertyName] != null) {
				//if (Type.getClass(property) != Type.getClass(_properties[propertyName])) {
					////TODO warning
					//trace("WARNING");
				//}
			//}
		//}
		//}else{
			//_properties[propertyName] = property;
			//property._onAdd(this);
		//}
		//if (_story != null) {
			//_story._actorRecievedProperty(this);
		//}
	//}
	
	public function addProperty(propertyName:String, p_property:AbstractProperty):Property {
		var property:Property = p_property;
		if (property == null || propertyName == null) {
			//TODO error
			trace( "propery error name="+propertyName);
			return null;
		}
		
		if (_properties[propertyName] != null) {
			//TODO error
			trace("Already added");
			if (Type.getClass(property) == Type.getClass(_properties[propertyName])) {
				trace("Property " + propertyName+" already added");
				return null;
			}else {
				trace("Try to add property with same name but different type");
			}
		}
		_properties[propertyName] = property;
		property._onAdd(this);

		if (_story != null) {
			_story._actorRecievedProperty(this);
		}
		return property;
	}
	
	public function getProperty(propertyName:String):Property {
		return _properties[propertyName];
	}
	
	//public function setPropety(propertyName:String, value:Dynamic, createIfNotFound:Bool = false):Void {
		//var property:Property;
		//if (!_properties.exists(propertyName)) {
			//if (createIfNotFound) {
				//property = addProperty(propertyName, value)
			//}
		//}
	//}

	public function hasProperty(propertyName:String):Bool {
		return _properties[propertyName] != null;
	}
	
	public function hasProperties(properties:Array<String>):Bool {
		for (name in properties) {
			if (!hasProperty(name)) {
				return false;
			}
		}
		return true;
	}
	
	public function removePropertyByName(propertyName:String):Void {
		if (_properties.exists(propertyName)) {
			_properties[propertyName]._onRemove(this);
			_properties.remove(propertyName);
		}
		
		if (_story != null) {
			for (role in _roles) 
			{
				_story._actorLostProperty(role);
			}
		}
	}
	
	private function _removeAllPropertiesOnDestroy():Void {
		for (property in _properties) {
			property._onRemove(this);
		}
		_properties = null;
	}
	// ---------- Tags ----------
	
	public function addTag(tag:Tag):Void {
		for (i in 0..._tags.length) {
			if (_tags[i] == tag) {
				return;
			}
		}
		_tags.push(tag);
		//TODO предупредить всех об измеениях
		if (_story != null) {
			_story.markAsTagModified(this);
		}
	}
	
	public function hasTag(tag:Tag):Bool {
		for (i in 0..._tags.length) {
			if (_tags[i] == tag) {
				return true;
			}
		}
		return false;
	}
	//TODO оптимизировать чтобы после нескольких добавлений/удалений один раз проверялось
	public function removeTag(tag:Tag):Void {
		for (i in 0..._tags.length) {
			if (_tags[i] == tag) {
				_tags.splice(i, 1);
				if (_story != null) {
					_story.markAsTagModified(this);
				}
				return;
			}
		}
	}
	// ---------- Roles ----------
	//@:allow(cinema.Story)
	//private function _addRole(role:Role):Void 
	//{
		//_roles.push(role);
	//}
	public function getRole(roleName:String):Role
	{
		if (_hasRole(roleName))
		{
			return _roles[roleName];
		}
		return null;
	}
	
	@:allow(cinema.Hunter)
	private function _requestRole(roleName:String):Role
	{
		if (_hasRole(roleName))
		{
			return _roles[roleName];
		}
		else
		{
			var roleModel = _story.getRoleModel(roleName);
			var role = roleModel.createRole(this);
			_roles[roleName] = role;
			return role;
		}
	}
	
	@:allow(cinema.Story)
	private inline function _hasRole(roleName:String):Bool 
	{
		return _roles.exists(roleName);
	}
	
	//@:allow(cinema.Story)
	//private function _getRoles():Array<Role> 
	//{
		//return _roles;
	//}
	
	private var _properties:Map<String, Property> = new Map();
	private var _tags:Array<Tag> = [];
	//TODO заменить на дикшонари
	private var _roles:Map<String, Role> = new Map();
	
	private var _story:Story;
}