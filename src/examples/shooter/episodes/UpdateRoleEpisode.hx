package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import framework.roles.IUpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class UpdateRoleEpisode extends Episode
{
	public var hunter:Hunter;
	
	private var _roleToUpdate:Array<IUpdatedRole> = [];
	public function new() 
	{
		super();
		
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		hunter = _createHunter(null, _roleToUpdate);
	}
	
	override public function update(dt:Float):Void 
	{
		for (role in _roleToUpdate) {
			role.update(dt);
		}
	}
	
}