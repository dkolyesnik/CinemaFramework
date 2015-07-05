package examples.shooter;
import cinema.Actor;
import cinema.IActorsFactory;
import cinema.properties.FloatProperty;
import cinema.properties.IntProperty;
import cinema.Story;
import cinema.Tag;
import framework.modules.render.simpleDORender.properties.DisplayObjectProperty;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ActorFactory implements IActorsFactory
{
	private var _story:Story;
	public function new() 
	{
	}
	
	public function setStory(story:Story):Void {
		_story = story;
	}
	public function removeStory():Void {
		_story = null;
	}
	
	public function create(type:String, name:String = ""):Actor {
		var actor:Actor = null;
		switch (type) 
		{
			case "random":
				actor = _createActor(name);
			case "enemy":
				actor = _createActor(name, 0xFF00FF, 15, 3, ["enemy"]);
			case "player":
				actor = _createActor(name == ""?"player":name, 0xFF0000, 18, 10, ["follow", "player"]);
				actor.addProperty("bulletType", "bullet");
			case "bullet":
				actor = _createActor(name, 0xFFFF00, 5, 6, ["bullet"]);
				actor.addProperty("speed", 5.0);
				
			default:
				
		}
		return actor;
	}
	
	private function _createActor(name:String = "", color:UInt = 0x004080 , radius:Float = 15, layer:Int = -1, tags:Array<Tag> = null):Actor {
		var actor = _story.createActor(name);
		actor.addProperty("x", Math.random() * 700 + 50);
		actor.addProperty("y", Math.random() * 400 + 50);
		actor.addProperty("width", radius * 2);
		actor.addProperty("height", radius * 2);
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