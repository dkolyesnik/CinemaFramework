package examples.shooter;

import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Story;
import cinema.Tag;
import examples.shooter.episodes.DisplayObjectRenderEpisode;
import examples.shooter.episodes.FollowMouseEpisode;
import examples.shooter.episodes.MouseCursorEpisode;
import examples.shooter.properties.DisplayObjectProperty;
import examples.Test;
import examples.test1.DrawEpisode;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ShooterTest extends Test
{
	
	private var _factory:ActorFactory;

	public function new(main:Sprite) 
	{
		super(main);
		
	}
	
	override public function start(params:Dynamic):Void 
	{
		super.start(params);
		//TODO возможно надо слой передавать в саму стори, тогда у эпизодов будет доступ к базовому спрайту
		_story = new Story();
		_factory = new ActorFactory(_story);
		
		var mouseCursorEpisode:MouseCursorEpisode = new MouseCursorEpisode(_bg);
		_story.addEpisode(mouseCursorEpisode);
		
		var followMouseEpisode:FollowMouseEpisode = new FollowMouseEpisode();
		followMouseEpisode.hunter.filter.withTags(["follow"]);
		_story.addEpisode(followMouseEpisode);
		
		
		var renderEpisode:DisplayObjectRenderEpisode = new DisplayObjectRenderEpisode(_storyLayer);
		_story.addEpisode(renderEpisode);
	
		
		for (i in 0...20) {
			_factory.create("random");
		}
		
		_factory.create("player");
		
		
		_story.begin();
	}
	
	
	
	
	
}

