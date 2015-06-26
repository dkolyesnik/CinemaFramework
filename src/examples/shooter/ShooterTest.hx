package examples.shooter;

import cinema.properties.IntProperty;
import cinema.Story;
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
		
		var drawEpisode:DrawEpisode = new DrawEpisode(_storyLayer);
		
		for (i in 0...10) {
			
		}
		
		_story.begin();
	}
	
	
	private function createActor():Void {
		var actor = _story.createActor();
		actor.addProperty("x", new IntProperty());
		actor.addProperty("y", new IntProperty());
		actor.addProperty("radius", new IntProperty(11));
	}
	
}

