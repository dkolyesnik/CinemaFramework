package cinema;
import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Actor
{

	public function new() 
	{
		
	} 
	
	@:allow(cinema.Story)
	private function _initialize(story:Story):Void {
		_story = story;
	}
	
	@:allow(cinema.Story)
	private function _onRemove():Void {
		for (hero in _heroes) {
			_story._removeHeroFromHunters(hero);
		}
		_destroy();
	}
	
	/**
	  Called when story is ended
	**/
	@:allow(cinema.Story)
	private function _destroy():Void {
		_story = null;
		_heroes = null;
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
		if (_story != null) {
			_story._actorRecievedProperty(this);
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
		
		if (_story != null) {
			for (hero in _heroes) {
				_story._actorLostProperty(hero);
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
			for (hero in _heroes) {
				_story._actorTagsModified(hero);
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
		if (_story != null) {
			for (hero in _heroes) {
				_story._actorTagsModified(hero);
			}
		}
	}
	// ---------- Heroes and Roles ----------
	@:allow(cinema.Story)
	private function _addHero(hero:Hero):Void {
		_heroes.push(hero);
	}
	
	@:allow(cinema.Story)
	private function _hasHeroForRole(role:Role):Bool {
		for (hero in _heroes) {
			if (hero.role == role) {
				return true;
			}
		}
		return false;
	}
	
	
	private var _properties:Map<String, Property> = new Map();
	private var _tags:Array<Tag> = [];
	private var _heroes:Array<Hero> = [];
	
	private var _story:Story;
}