package cinema.properties;

import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class IntProperty extends Property
{

	public function new(defaultValue:Int = 0) 
	{
		super();
		value = defaultValue;
	}
	
	public var value:Int;
	
}