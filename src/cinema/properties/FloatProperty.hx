package cinema.properties;

import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class FloatProperty extends Property
{

	public function new(defaultValue:Float = 0) 
	{
		super();
		value = defaultValue;
	}
	
	public var value:Float;
	
}