package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Story;
import examples.shooter.episodes.DisplayObjectRenderEpisode.Layer;
import examples.shooter.episodes.misc.RenderTags;
import examples.shooter.roles.DisplayObjectRole;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DisplayObjectRenderEpisode extends Episode
{
	public var displayObjectHunter:Hunter;
	public var displayObjectsToUpdateParentHunter:Hunter;
	public var displayObjectsOnStageHunter:Hunter;
	
	private var _mainLayer:Sprite;
	private var _layers:Array<Layer> = [];
	private var _layerByPriority:Map<Int, Layer> = new Map();
	
	private var _displayObjects:Array<DisplayObjectRole> = [];
	private var _displayObjectsoUpdateParent:Array<DisplayObjectRole> = [];
	private var _displayObjectsOnStage:Array<DisplayObjectRole> = [];
	
	public function new(mainLayer:Sprite) 
	{
		super();
		_mainLayer = mainLayer;
	}
	
	override function _setupHunters():Void 
	{
		displayObjectHunter = _createHunter(DisplayObjectRole, _displayObjects);
		displayObjectsToUpdateParentHunter = _createHunter(DisplayObjectRole, _displayObjectsoUpdateParent);
		displayObjectHunter.filter.withTags([RenderTags.UPDATE_PARENT]);
		displayObjectsOnStageHunter = _createHunter(DisplayObjectRole, _displayObjectsOnStage);
		displayObjectsOnStageHunter.filter.withTags([RenderTags.ON_STAGE]);
	}
	
	override public function update(dt:Float):Void 
	{
		for (displayObject in _displayObjectsoUpdateParent) {
			getLayer(displayObject.layer).addChild(displayObject.displayObject);
			displayObject.actor.removeTag(RenderTags.UPDATE_PARENT);
		}
		
		for (displayObject in _displayObjects) {
			displayObject.update(dt);
		}
	}
	
	private function getLayer(priority:Int):Layer {
		if (_layerByPriority.exists(priority)) {
			return _layerByPriority.get(priority);
		}
		var layer = new Layer();
		layer.priority = priority;
		_layerByPriority[priority] = layer;
		//TODO oprimize
		for (i in 0..._layers.length) {
			if (_layers[i].priority < priority) {
				_layers.insert(i, layer);
				_mainLayer.addChildAt(layer, i);
				return layer;
			}
		}
		_layers.push(layer);
		_mainLayer.addChild(layer);
		return layer;
	}
}

class Layer extends Sprite
{
	public var priority:Int;
	public function new() 
	{
		super();
		
	}
	
}