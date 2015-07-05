package examples.shooter;

import cinema.IActorsFactory;
import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Role;
import cinema.Story;
import cinema.Tag;
import examples.shooter.episodes.CollisionEpisode;
import framework.modules.render.simpleDORender.episodes.DisplayObjectRenderEpisode;
import examples.shooter.episodes.DoActionsEpisode;
import examples.shooter.episodes.DoOnTimerEpisode;
import examples.shooter.episodes.FollowMouseEpisode;
import examples.shooter.episodes.misc.DelayEpisodeTimer;
import framework.modules.input.simpleMouse.episodes.MouseInputEpisode;
import examples.shooter.episodes.RemoveOnLeaveBorderEpisode;
import examples.shooter.episodes.ShootOnClickEpisode;
import examples.shooter.episodes.UpdateRoleEpisode;
import framework.modules.render.simpleDORender.properties.DisplayObjectProperty;
import examples.shooter.roles.ColliderRole;
import examples.shooter.roles.MovingRole;
import framework.common.roles.PositionRole;
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
		
		// mouse input
		_story.addEpisode(new MouseInputEpisode(_bg));
		
		// spawnEnemies
		_story.addEpisode(new DoOnTimerEpisode().setTimer(new DelayEpisodeTimer(120)).setHandler(spawnEnemies));
		
		
		// follow mouse
		var followMouseEpisode:FollowMouseEpisode = new FollowMouseEpisode();
		followMouseEpisode.hunter.filter.withTags(["follow"]);
		_story.addEpisode(followMouseEpisode);
		
		// player mods
		var actionsEpisode:DoActionsEpisode = new DoActionsEpisode().addAction(checkHeight);
		actionsEpisode.hunter.setRoleClass(PositionRole).filter.withTags(["player"]);
		_story.addEpisode(actionsEpisode);
		
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
	
	private function spawnEnemies():Void
	{
		var num:Int = Std.int(Math.random() * 3) + 1;
		while (num-- >= 0) {
			_factory.create("enemy");
		}
		
	}
	
	private function checkHeight(p_story:Story, role:Role):Void {
		var position:PositionRole = cast role;
		if (position.y < 400) {
			position.y = 400;
		}
	}
	
	private function removeOnCollideHandler(collider:Role, collidee:Role) 
	{
		_story.removeActor(collider.actor);
	}
	
	
	
	
	
}

