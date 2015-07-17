package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import cinema.roles.IUpdatedRole;
import cinema.roles.UpdatedRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class UpdateRoleEpisode extends Episode
{
	public var hunter:Hunter<UpdatedRole>;
	
	public function new() 
	{
		super();
		
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		//TODO error 
		_hunters.push( cast hunter );
	}
	
	override public function update(dt:Float):Void 
	{
		for (role in hunter) {
			role.update(dt);
		}
	}
	
}