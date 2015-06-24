package examples.test1;
import cinema.Hunter;
import cinema.properties.IntProperty;
import openfl.display.Sprite;
import cinema.Episode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DrawEpisode extends Episode
{
	public var renderObjectHunter:Hunter;
	
	private var _renderObjects:Array<RenderObjectHero> = [];
	
	public function new(main:Sprite) 
	{
		super();
		_episode = main;
		renderObjectHunter = _createHunter(RenderObjectRole, _renderObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		_episode.graphics.clear();
		_episode.graphics.beginFill(0x004080);
		for (renderObject in _renderObjects) {
			_episode.graphics.drawCircle(renderObject.x, renderObject.y, renderObject.radius);
		}
		_episode.graphics.endFill();
	}
	
	
	private var _episode:Sprite;
}