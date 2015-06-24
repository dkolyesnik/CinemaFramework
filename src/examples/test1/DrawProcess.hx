package examples.test1;
import cinema.Selector;
import cinema.properties.IntProperty;
import openfl.display.Sprite;
import cinema.Process;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DrawProcess extends Process
{
	public var renderObjectSelector:Selector;
	
	private var _renderObjects:Array<RenderObjectGO> = [];
	
	public function new(main:Sprite) 
	{
		super();
		_spr = main;
		
	}
	override function _initializeSelectors():Void 
	{
		renderObjectSelector = _createSelector(RenderObjectGODef, _renderObjects);
	}
	
	override public function update(dt:Float):Void 
	{
		_episode.graphics.clear();
		_episode.graphics.beginFill(0x004080);
		for (renderObject in _renderObjects) {
			_episode.graphics.drawCircle(renderObject.x, renderObject.y, renderObject.radius);
		}
		_spr.graphics.endFill();
	}
	
	
	private var _spr:Sprite;
}