package cinema.filters.conditions;
import cinema.Actor;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ActorNameFilterCondition extends FilterCondition
{
	private var _actorName:String;
	public function new(name:String) 
	{
		super();
		_actorName = name;
	}
	
	override public function check(actor:Actor):Bool 
	{
		return _actorName == actor.name;
	}
	
}