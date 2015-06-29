package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import examples.shooter.roles.ColliderRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class CollisionEpisode extends Episode
{
	public var colliderHunter:Hunter;
	public var collideeHunter:Hunter;
	
	private var _colliders:Array<ColliderRole> = [];
	private var _collidees:Array<ColliderRole> = [];
	
	private var _colliderOnCollide:Role-> Role-> Void = null;
	private var _collideeOnCollide:Role-> Role-> Void = null;
	
	public function new() 
	{
		super();
		
	}
	
	public function setColliderHandler(handler:Role-> Role-> Void):Void {
		_colliderOnCollide = handler;
	}
	
	public function setCollideeHandler(handler:Role-> Role-> Void):Void {
		_collideeOnCollide = handler;
	}
	
	override function _setupHunters():Void 
	{
		super._setupHunters();
		colliderHunter = _createHunter(ColliderRole, _colliders);
		collideeHunter = _createHunter(ColliderRole, _collidees);
	}
	
	override public function update(dt:Float):Void 
	{
		for (collider in _colliders) {
			for (collidee in _collidees) {
				if (calcDistance(collider.x, collider.y, collidee.x, collidee.y) < pow(collider.radius + collidee.radius)) {
					if (_colliderOnCollide != null) {
						_colliderOnCollide(collider, collidee);
					}
					if (_collideeOnCollide != null) {
						_collideeOnCollide(collidee, collider);
					}
				}
			}
		}
	}
	
	
	public static inline function calcDistance(x:Float, y:Float, x1:Float, y1:Float):Float {
		return pow(x - x1) + pow(y - y1);
	}
	public static inline function pow(x:Float):Float {
		return x * x;
	}
}