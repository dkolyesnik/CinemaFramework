package cinema.properties;
import cinema.Actor;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ArrayProperty<T> extends Property
{
	public var value(get, null):Array<T>;
	
	public function new() 
	{
		super();
		value = [];
	}
	
	private inline function get_value():Array<T>
	{
		return value;
	}
	
	override function _onAdd(actor:Actor):Void 
	{
		super._onAdd(actor);
		if ( value == null )
		{
			value = [];
		}
	}
	
	override function _onRemove(actor:Actor):Void 
	{
		super._onRemove(actor);
		value = null;
	}
	
}