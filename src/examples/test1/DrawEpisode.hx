package examples.test1;
import cinema.Hunter;
import cinema.properties.IntProperty;
import cinema.Story;
import openfl.display.Sprite;
import cinema.Episode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DrawEpisode extends Episode
{
	public var renderObjectHunter:Hunter;
	
	private var _renderObjects:Array<RenderHero> = [];
	
	public function new(main:Sprite) 
	{
		super();
		_spr = main;
	}
	
	override function _setupHunters():Void 
	{
		renderObjectHunter = _createHunter(RenderRole, _renderObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		_spr.graphics.clear();
		_spr.graphics.beginFill(0x004080);
		for (renderObject in _renderObjects) {
			_spr.graphics.drawCircle(renderObject.x, renderObject.y, renderObject.radius);
		}
		_spr.graphics.endFill();
	}
	
	
	private var _spr:Sprite;
}