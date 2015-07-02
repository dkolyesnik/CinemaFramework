package cinema.filters;
import cinema.Actor;
import cinema.filters.conditions.ActorNameFilterCondition;
import cinema.filters.conditions.NoTagsFilterCondition;
import cinema.filters.conditions.WithTagsFilterCondition;
import cinema.Tag;

/**
 * ...
 * @author Kolyesnik D.V.
 */

//RENAME - producer
class Filter implements IFilterSetup
{
	public function new() 
	{
		_conditions = [];
	}
	
	public function withTags(tags:Array<Tag>):IFilterSetup {
		_addCondition(new WithTagsFilterCondition(tags));
		return this;
	}
	
	public function noTags(tags:Array<Tag>):IFilterSetup {
		_addCondition(new NoTagsFilterCondition(tags));
		return this;
	}
	
	public function actorName(name:String):IFilterSetup {
		_addCondition(new ActorNameFilterCondition(name));
		return this;
	}
	
	public function customCondition(condition:FilterCondition):IFilterSetup {
		_addCondition(condition);
		return this;
	}
	
	public function check(actor:Actor):Bool {
		for (condition in _conditions) {
			if (!condition.check(actor)) {
				return false;
			}
		}
		return true;
	}
	
	private function _addCondition(condition:FilterCondition):Void {
		_conditions.push(condition);	
	}
		
	private var _conditions:Array<FilterCondition>;
	
	//public function withProperties(properties:Array<String>):FilterAdder {
		//_holder.addFilter(new WithTagsFilter(tags));
		//return this;
	//}
	//
	//public function noProperties(properties:Array<String>):FilterAdder {
		////_holder.addFilter(new 
	//}
}