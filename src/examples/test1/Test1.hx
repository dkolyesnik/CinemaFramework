package examples.test1;
import cinema.Entity;
import cinema.properties.IntProperty;
import examples.Test;
import openfl.display.Sprite;
import openfl.events.Event;
import cinema.Core;

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
		
		
		var drawProcess:DrawProcess = new DrawProcess(_layer);
		drawProcess.renderObjectSelector.selectEntitys.noTags(["invisible"]);
		_core.addProcess(drawProcess);
		
		_core.addProcess(new MoveProcess());
		
		var randomHide:RandomActionProcess = new RandomActionProcess(90, hideEntity);
		randomHide.selector.selectEntitys.noTags(["invisible"]);
		_core.addProcess(randomHide);
		
		var randomShow:RandomActionProcess = new RandomActionProcess(90, showEntity);
		randomShow.selector.selectEntitys.withTags(["invisible"]);
		_core.addProcess(randomShow);
		
		
		for (i in 0...1000) {
			_hireEntity();
		}
		_core.begin();
	}
	
	private function hideEntity(entity:Entity):Void {
		entity.addTag("invisible");
	}
	
	private function showEntity(entity:Entity):Void {
		entity.removeTag("invisible");
	}
	
	//misc
	private function _hireEntity():Void {
		var entity:Entity = _core.allocateEntity();
		entity.addProperty("x", new IntProperty(Std.int(Math.random() * 700 + 50)));
		entity.addProperty("y", new IntProperty(Std.int(Math.random() * 500 + 50)));
		entity.addProperty("radius", new IntProperty(10));
	}
}