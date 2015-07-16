package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import cinema.Story;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DoActionsEpisode extends Episode
{
	public var hunter:Hunter<Role>;
	
	private var _roles:Array<Role> = [];
	
	private var _actions:Array<Story->Role->Void> = [];

	public function new() 
	{
		super();
		
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		hunter = _createHunter(null, _roles);
	}
	
	public function addAction(action:Story->Role-> Void):DoActionsEpisode {
		_actions.push(action);
		return this;
	}
	
	override public function update(dt:Float):Void 
	{
		for (role in _roles) {
			for (action in _actions) {
				action(_story, role);
			}
		}
	}
	
}