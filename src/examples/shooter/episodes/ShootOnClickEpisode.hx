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
	public var shootersHunter:Hunter<Role>;
	
	private var _shooters:Array<ShooterRole> = [];
	
	// не самый оптимизирвоанный вариант, но удобно
	private var _bulletPosition:PositionRole;
	
	public function new() 
	{
		super();
		_bulletPosition = new PositionRole();
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		shootersHunter = _createHunter(ShooterRole, _shooters);
	}
	
	override public function update(dt:Float):Void 
	{
		
		if (mouse.isClicked()) {
			for (shooter in _shooters) {
				_bulletPosition.initialize(_story.createByFactory(shooter.bulletType));
				if (_bulletPosition != null) {
					_bulletPosition.x = shooter.x;
					_bulletPosition.y = shooter.y;
				}
			}
		}
	}
	
}