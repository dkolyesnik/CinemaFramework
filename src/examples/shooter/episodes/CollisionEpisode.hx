package 
examples.shooter.episodes;
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
	public var collider1Hunter:Hunter<ColliderRole>;
	public var collider2Hunter:Hunter<ColliderRole>;
	
	private var _collider1_OnCollide:Role-> Role-> Void = null;
	private var _collider2_OnCollide:Role-> Role-> Void = null;
	
	public function new() 
	{
		super();
		
	}
	
	public function setColliderHandler(handler:Role-> Role-> Void):Void {
		_collider1_OnCollide = handler;
	}
	
	public function setCollideeHandler(handler:Role-> Role-> Void):Void {
		_collider2_OnCollide = handler;
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new ColliderRole());
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		collider1Hunter = new Hunter<ColliderRole>(ColliderRole.NAME);
		collider2Hunter = new Hunter<ColliderRole>(ColliderRole.NAME);
		
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		_hunters.push( cast collider1Hunter);
		_hunters.push( cast collider2Hunter);
	}
	
	override public function update(dt:Float):Void 
	{
		for (collider1 in collider1Hunter) {
			for (collider2 in collider2Hunter) {
				if (calcDistance(collider1.x, collider1.y, collider2.x, collider2.y) < pow(collider1.radius + collider2.radius)) {
					if (_collider1_OnCollide != null) {
						_collider1_OnCollide(collider1, collider2);
					}
					if (_collider2_OnCollide != null) {
						_collider2_OnCollide(collider2, collider1);
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