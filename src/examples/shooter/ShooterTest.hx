package examples.shooter;

import cinema.IActorsFactory;
import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Role;
import cinema.Story;
import cinema.Tag;
import examples.shooter.episodes.CollisionEpisode;
import examples.shooter.episodes.DisplayObjectRenderEpisode;
import examples.shooter.episodes.FollowMouseEpisode;
import examples.shooter.episodes.MouseCursorEpisode;
import examples.shooter.episodes.RemoveOnLeaveBorderEpisode;
import examples.shooter.episodes.ShootOnClickEpisode;
import examples.shooter.episodes.UpdateRoleEpisode;
import examples.shooter.properties.DisplayObjectProperty;
import examples.shooter.roles.ColliderRole;
import examples.shooter.roles.MovingRole;
import examples.Test;
import examples.test1.DrawEpisode;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ShooterTest extends Test
{
	
	private var _factory:IActorsFactory;

	public function new(main:Sprite) 
	{
		super(main);
		
	}
	
	override public function start(params:Dynamic):Void 
	{
		super.start(params);
		//TODO возможно надо слой передавать в саму стори, тогда у эпизодов будет доступ к базовому спрайту
		_story = new Story();
		_factory = _story.setFactory(new ActorFactory());
		
		
		_story.addEpisode(new MouseCursorEpisode(_bg));
		
		// follow mouse
		var followMouseEpisode:FollowMouseEpisode = new FollowMouseEpisode();
		followMouseEpisode.hunter.filter.withTags(["follow"]);
		_story.addEpisode(followMouseEpisode);
		
		// collision 
		var collisionEpisode:CollisionEpisode = new CollisionEpisode();
		collisionEpisode.colliderHunter.filter.withTags(["bullet"]);
		collisionEpisode.collideeHunter.filter.withTags(["enemy"]);
		collisionEpisode.setColliderHandler(removeOnCollideHandler);
		collisionEpisode.setCollideeHandler(removeOnCollideHandler);
		_story.addEpisode(collisionEpisode);
		
		// move
		var moveEpisode:UpdateRoleEpisode = new UpdateRoleEpisode();
		moveEpisode.hunter.setRoleClass(MovingRole).filter.withTags(["bullet"]);
		_story.addEpisode(moveEpisode);
		
		
		
		// remove when leave screen
		var removeOnLeaveScreenEpisode:RemoveOnLeaveBorderEpisode = new RemoveOnLeaveBorderEpisode(0, 800, 0, 600);
		removeOnLeaveScreenEpisode.hunter.filter.withTags(["bullet"]);
		_story.addEpisode(removeOnLeaveScreenEpisode);
		
		// shoot on click
		var shootEposide:ShootOnClickEpisode = new ShootOnClickEpisode();
		//shootEposide.shootersHunter.filter.
		_story.addEpisode(shootEposide);
		
		// render
		var renderEpisode:DisplayObjectRenderEpisode = new DisplayObjectRenderEpisode(_storyLayer);
		_story.addEpisode(renderEpisode);
	
		
		for (i in 0...20) {
			_factory.create("enemy");
		}
		
		_factory.create("player");
		
		
		_story.begin();
	}
	
	private function removeOnCollideHandler(collider:Role, collidee:Role) 
	{
		_story.removeActor(collider.actor);
	}
	
	
	
	
	
}

