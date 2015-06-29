package cinema.properties;
import cinema.properties.Property;

/**
 * ...
 * @author Kolyesnik D.V.
 */
abstract AbstractProperty(Property) from Property to Property
{
	public function new(property:Property) 
	{
		this = property;
	}
	
	@:from
	public static function fromInt(value:Int):AbstractProperty {
		return new AbstractProperty(new IntProperty(value));
	}
	
	@:from
	public static function fromFloat(value:Float):AbstractProperty {
		return new AbstractProperty(new FloatProperty(value));
	}
	
	@:from
	public static function fromString(value:String):AbstractProperty {
		return new AbstractProperty(new StringProperty(value));
	}
}