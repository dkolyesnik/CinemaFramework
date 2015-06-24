package cinema;
import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Entity
{

	public function new() 
	{
		
	} 
	
	@:allow(cinema.Core)
	private function _initialize(core:Core):Void {
		_core = core;
	}
	
	@:allow(cinema.Core)
	private function _onRemove():Void {
		for (go in _goes) {
			_core._removeGOFromSelectors(go);
		}
		_destroy();
	}
	
	/**
	  Called when core is ended
	**/
	@:allow(cinema.Core)
	private function _destroy():Void {
		_core = null;
		_goes = null;
		_tags = null;
		_removeAllPropertiesOnDestroy();
	}
	
	// ---------- Properties ----------
	public function addProperty(propertyName:String, property:Property):Void {
		if (property == null){
			//TODO error
			trace("ERROR1");
		}else if (_properties[propertyName] != null) {
			if (Type.getClass(property) != Type.getClass(_properties[propertyName])) {
				//TODO warning
				trace("WARNING");
			}
		}else{
			_properties[propertyName] = property;
			property._onAdd(this);
		}
		if (_core != null) {
			_core._entityRecievedProperty(this);
		}
	}
	
	public function getProperty(propertyName:String):Property {
		return _properties[propertyName];
	}

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
		
		if (_core != null) {
			for (go in _goes) {
				_core._entityLostProperty(go);
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
		if (_core != null) {
			for (go in _goes) {
				_core._entityTagsModified(go);
			}
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
	
	public function removeTag(tag:Tag):Void {
		for (i in 0..._tags.length) {
			if (_tags[i] == tag) {
				_tags.splice(i, 1);
				return;
			}
		}
		//TODO предупредить всех об измеениях
		if (_core != null) {
			for (go in _goes) {
				_core._entityTagsModified(go);
			}
		}
	}
	// ---------- GOes and GODefs ----------
	@:allow(cinema.Core)
	private function _addGO(go:GameObject):Void {
		_goes.push(go);
	}
	
	@:allow(cinema.Core)
	private function _hasGOForGODef(goDef:GameObjectDef):Bool {
		for (go in _goes) {
			if (go.goDef == goDef) {
				return true;
			}
		}
		return false;
	}
	
	
	private var _properties:Map<String, Property> = new Map();
	private var _tags:Array<Tag> = [];
	private var _goes:Array<GameObject> = [];
	
	private var _core:Core;
}