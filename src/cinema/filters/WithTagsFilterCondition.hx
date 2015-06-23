package cinema.filters;
import cinema.Actor;
import cinema.Tag;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class WithTagsFilterCondition extends FilterCondition
{
	private var _tags:Array<Tag>;
	public function new(tags:Array<String>) 
	{
		super();
		_tags = tags;
	}
	
	override public function check(actor:Actor):Bool 
	{
		for (i in 0..._tags.length) {
			if (actor.hasTag(_tags[i])) {
				return true;
			}
		}
		return false;
	}
}