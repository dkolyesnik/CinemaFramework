package examples.shooter.properties;

import cinema.Actor;
import cinema.properties.Property;
import examples.shooter.episodes.misc.RenderTags;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DisplayObjectProperty extends Property
{

	private var _actor:Actor;
	
	public var value(get, set):DisplayObject;
	
	private var _displayObject:DisplayObject;
	
	public function new(displObject:DisplayObject) 
	{
		_displayObject = displObject;
		super();
		
	}
	
	override function _onAdd(actor:Actor):Void 
	{
		_actor = actor;
		_actor.addTag(RenderTags.UPDATE_PARENT);
	}
	
	override function _onRemove(actor:Actor):Void 
	{
		_actor = null;
		if (_displayObject.parent != null) {
			_displayObject.parent.removeChild(_displayObject);
		}
		_displayObject = null;
	}
	
	function get_value():DisplayObject 
	{
		return _displayObject;
	}
	
	function set_value(p_value:DisplayObject):DisplayObject 
	{
		if (_displayObject == p_value)
			return _displayObject;
		if (_displayObject.parent != null) {
			_displayObject.parent.removeChild(_displayObject);
			_actor.removeTag(RenderTags.ON_STAGE);
		}
		_actor.addTag(RenderTags.UPDATE_PARENT);
		return _displayObject = p_value;
	}
	
}