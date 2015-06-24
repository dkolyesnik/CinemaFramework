package examples.test1;
import cinema.Actor;
import cinema.properties.IntProperty;
import examples.Test;
import openfl.display.Sprite;
import openfl.events.Event;
import cinema.Story;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Test1 extends Test
{
	public function new(main:Sprite) 
	{
		super(main);
	}
	
	override public function start(params:Dynamic):Void {
		super.start(params);
		
		
		var drawEpisode:DrawEpisode = new DrawEpisode(_story, _layer);
		drawEpisode.renderObjectHunter.selectActors.noTags(["invisible"]);
		drawEpisode.initialize();
		
		new MoveEpisode(_story).initialize();
		
		var randomHide:RandomActionEpisode = new RandomActionEpisode(_story, 90, hideActor);
		randomHide.hunter.selectActors.noTags(["invisible"]);
		randomHide.initialize();
		
		var randomShow:RandomActionEpisode = new RandomActionEpisode(_story, 90, showActor);
		randomShow.hunter.selectActors.withTags(["invisible"]);
		randomShow.initialize();
		
		
		for (i in 0...1000) {
			_hireActor();
		}
		_story.begin();
	}
	
	private function hideActor(actor:Actor):Void {
		actor.addTag("invisible");
	}
	
	private function showActor(actor:Actor):Void {
		actor.removeTag("invisible");
	}
	
	//misc
	private function _hireActor():Void {
		var actor:Actor = _story.hireActor();
		actor.addProperty("x", new IntProperty(Std.int(Math.random() * 700 + 50)));
		actor.addProperty("y", new IntProperty(Std.int(Math.random() * 500 + 50)));
		actor.addProperty("radius", new IntProperty(10));
	}
}