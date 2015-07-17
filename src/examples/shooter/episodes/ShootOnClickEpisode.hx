package examples.shooter.episodes;
import cinema.Actor;
import cinema.Hunter;
import cinema.Role;
import framework.common.roles.PositionRole;
import examples.shooter.roles.ShooterRole;
import framework.modules.input.simpleMouse.episodes.BaseMouseEpisode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ShootOnClickEpisode extends BaseMouseEpisode
{
	public var shootersHunter:Hunter<ShooterRole>;
	
	// не самый оптимизирвоанный вариант, но удобно
	private var _bulletPosition:PositionRole;
	
	public function new() 
	{
		super();
		_bulletPosition = new PositionRole();
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new ShooterRole());
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		shootersHunter = new Hunter<ShooterRole>(ShooterRole.NAME);
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		_hunters.push( cast shootersHunter );
	}
	
	override public function update(dt:Float):Void 
	{
		
		if (mouse.isClicked()) {
			for (shooter in shootersHunter) {
				_bulletPosition.initialize(_story.createByFactory(shooter.bulletType));
				if (_bulletPosition != null) {
					_bulletPosition.x = shooter.x;
					_bulletPosition.y = shooter.y;
				}
			}
		}
	}
	
}