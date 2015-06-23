package core;
import cinema.properties.Property;
import core.role.GameObject;
import core.role.Selector;
import cinema.Tag;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class Entity
{
	public function new(p_core:Core) {
		_properties = new Map();
		_tags = [];
		_core = p_core;
	}
	
	//@:allow(core.Core)
	//private function destroy():Void {
		//for (role in _acceptedRoles) {
			//role.removeEntity(this);
		//}
		//_properties = null;
		//_acceptedRoles = null;
		//_tags = null;
	//}
	//
	//// properties
	//public function addProperty(propertyName:String, property:Property):Void {
		//if(_properties[propertyName] != null){
			////TODO error
			//trace("ERROR1");
		//}else{
			//_properties[propertyName] = property;
		//}
	//}
//
	//public function hasProperty(propertyName:String):Bool {
		//return _properties[propertyName] != null;
	//}
	//
	//public function hasProperties(properties:Array<String>):Bool {
		//for (name in properties) {
			//if (!hasProperty(name)) {
				//return false;
			//}
		//}
		//return true;
	//}
//
	//public function getProperty(propertyName:String):Property {
		//return _properties[propertyName];
	//}
//
	//public function removePropertyByName(propertyName:String):Void {
		//_properties.remove(propertyName);
	//}
	//
	//
	//// tags
	//
	//public function addTag(tag:Tag):Void {
		//for (i in 0..._tags.length) {
			//if (_tags[i] == tag) {
				//return;
			//}
		//}
		//_tags.push(tag);
		//_updateRoles();
	//}
	//
	//public function hasTag(tag:Tag):Bool {
		//for (i in 0..._tags.length) {
			//if (_tags[i] == tag) {
				//return true;
			//}
		//}
		//return false;
	//}
	//
	//public function removeTag(tag:Tag):Void {
		//for (i in 0..._tags.length) {
			//if (_tags[i] == tag) {
				//_tags.splice(i, 1);
				//return;
			//}
		//}
		//_updateRoles();
	//}
	//
	//// Roles
	//@:allow(core.role.RoleSetup)
	//public function addRole(role:RoleSetup):Void {
		//_acceptedRoles.push(role);
	//}
	//@:allow(core.role.RoleSetup)
	//public function removeRole(role:RoleSetup):Void {
		//for (i in 0..._acceptedRoles.length) {
			//if (_acceptedRoles[i] == role) {
				//_acceptedRoles.splice(i, 1);
				//return;
			//}
		//}
	//}
	//
	//private function _updateRoles():Void {
		//for (role in _acceptedRoles) {
			//role.updateEntity(this);
		//}
	//}
	
	private var _properties:Map<String, Property>;
	private var _tags:Array<Tag>;
	private var _roles:Array<GameObject>;
	
	private var _core:Core;
}