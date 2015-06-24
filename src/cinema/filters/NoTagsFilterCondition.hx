package cinema.filters;

import cinema.Entity;
import cinema.Tag;
import cinema.filters.FilterCondition;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class NoTagsFilterCondition extends FilterCondition
{

	private var _tags:Array<Tag>;
	public function new(tags:Array<String>) 
	{
		super();
		_tags = tags;
	}
	
	override public function check(entity:Entity):Bool 
	{
		for (i in 0..._tags.length) {
			if (entity.hasTag(_tags[i])) {
				return false;
			}
		}
		return true;
	}
}