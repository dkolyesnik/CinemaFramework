package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MoveToTargerEpisode extends Episode
{
	public var movingObjectHunter:Hunter<Role>;
	public var targetHunter:Hunter<Role>;
	
	public function new() 
	{
		super();
		
	}
	
	override function _setupHunters():Void 
	{
		//movingObjectHunter = _createHunter(
	}
	
	override public function update(dt:Float):Void 
	{
		
	}
	
}