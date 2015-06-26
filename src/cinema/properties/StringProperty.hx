package cinema.properties;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class StringProperty extends Property
{

	public function new(defaultValue:String = "") 
	{
		super();
		value = defaultValue;
	}
	
	public var value:String;
	
}