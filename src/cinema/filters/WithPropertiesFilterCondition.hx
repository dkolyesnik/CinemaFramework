package cinema.filters;

import cinema.filters.FilterCondition;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class WithPropertiesFilterCondition extends FilterCondition
{
	//TODO проверки проперти не только по имени. но и по типу
	private var _properties:Array<String>;
	public function new() 
	{
		super();
		
	}
	
}