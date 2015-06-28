package examples.shooter;
import cinema.Actor;
import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Story;
import cinema.Tag;
import examples.shooter.properties.DisplayObjectProperty;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ActorFactory
{
	private var _story:Story;
	public function new(story:Story ) 
	{
		_story = story;
	}
	
	public function create(type:String, name:String = ""):Actor {
		var actor:Actor;
		switch (type) 
		{
			case "random":
				return _createActor(name);
			case "player":
				return _createActor(name == ""?"player":name, 0xFF0000, 35, 10, ["follow"]);
			case "bullet":
				actor = _createActor(name, 0xFFFF00, 10, 6, ["bullet"]);
				actor.addProperty("speed", 3);
				return actor;
				
			default:
				
		}
		return null;
	}
	
	private function _createActor(name:String = "", color:UInt = 0x004080 , radius:Float = 30, layer:Int = -1, tags:Array<Tag> = null):Actor {
		var actor = _story.createActor(name);
		actor.addProperty("x", Math.random() * 700 + 50);
		actor.addProperty("y", Math.random() * 500 + 50);
		actor.addProperty("width", radius);
		actor.addProperty("height", radius);
		actor.addProperty("radius", radius);
		if (layer == -1)
			layer = Std.int(Math.random() * 4);
		actor.addProperty("layer", layer);
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(color);
		spr.graphics.drawCircle(0, 0, radius);
		spr.graphics.endFill();
		actor.addProperty("displayObject", new DisplayObjectProperty(spr));
		if (tags != null) {
			for (tag in tags) {
				actor.addTag(tag);
			}
		}
		return actor;
	}
	
}