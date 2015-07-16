package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import cinema.roles.IUpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class UpdateRoleEpisode extends Episode
{
	public var hunter:Hunter<Role>;
	
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