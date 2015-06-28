package examples.shooter;

import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Story;
import examples.shooter.episodes.DisplayObjectRenderEpisode;
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

	public function new(main:Sprite) 
	{
		super(main);
		
	}
	
	override public function start(params:Dynamic):Void 
	{
		super.start(params);
		
		_story = new Story();
		
		var renderEpisode:DisplayObjectRenderEpisode = new DisplayObjectRenderEpisode(_storyLayer);
		_story.addEpisode(renderEpisode);
		
		for (i in 0...10) {
			createActor();
		}
		
		_story.begin();
	}
	
	
	private function createActor():Void {
		var actor = _story.createActor();
		actor.addProperty("x", new FloatProperty(Math.random() * 700 + 50));
		actor.addProperty("y", new FloatProperty(Math.random() * 500 + 50));
		actor.addProperty("width", new FloatProperty(11));
		actor.addProperty("height", new FloatProperty(11));
		actor.addProperty("radius", new FloatProperty(11));
		actor.addProperty("layer", new IntProperty(Std.int(Math.random() * 4)));
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(0x8080FF);
		spr.graphics.drawCircle(0, 0, 11);
		spr.graphics.endFill();
		actor.addProperty("displayObject", new DisplayObjectProperty(spr));
	}
	
}

