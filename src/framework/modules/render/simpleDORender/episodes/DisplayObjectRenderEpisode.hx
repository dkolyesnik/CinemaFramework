package framework.modules.render.simpleDORender.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import cinema.Story;
import framework.modules.render.simpleDORender.tags.RenderTags;
import framework.modules.render.simpleDORender.roles.DisplayObjectRole;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DisplayObjectRenderEpisode extends Episode
{
	public var displayObjectHunter:Hunter<DisplayObjectRole>;
	public var displayObjectsToUpdateParentHunter:Hunter<DisplayObjectRole>;
	public var displayObjectsOnStageHunter:Hunter<DisplayObjectRole>;
	
	private var _mainLayer:Sprite;
	private var _layers:Array<Layer> = [];
	private var _layerByPriority:Map<Int, Layer> = new Map();
	
	public function new(mainLayer:Sprite) 
	{
		super();
		_mainLayer = mainLayer;
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new DisplayObjectRole());
		
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		displayObjectHunter = new Hunter<DisplayObjectRole>(DisplayObjectRole.NAME);
		
		displayObjectsToUpdateParentHunter = new Hunter<DisplayObjectRole>(DisplayObjectRole.NAME);
		displayObjectsToUpdateParentHunter.filter.withTags([RenderTags.UPDATE_PARENT]);
		
		displayObjectsOnStageHunter = new Hunter<DisplayObjectRole>(DisplayObjectRole.NAME);
		displayObjectsOnStageHunter.filter.withTags([RenderTags.ON_STAGE]);
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		_hunters.push( cast displayObjectHunter);
		_hunters.push( cast displayObjectsToUpdateParentHunter);
		_hunters.push( cast displayObjectsOnStageHunter);
	}
	
	override public function update(dt:Float):Void 
	{
		for (displayObject in displayObjectsToUpdateParentHunter) 
		{
			getLayer(displayObject.layer).addChild(displayObject.displayObject);
			displayObject.actor.removeTag(RenderTags.UPDATE_PARENT);
			displayObject.actor.addTag(RenderTags.ON_STAGE);
		}
		
		_story.updateActors();
		
		for (displayObject in displayObjectHunter) 
		{
			displayObject.update(dt);
		}
	}
	
	private function getLayer(priority:Int):Layer 
	{
		if (_layerByPriority.exists(priority)) 
		{
			return _layerByPriority.get(priority);
		}
		var layer = new Layer();
		layer.priority = priority;
		_layerByPriority[priority] = layer;
		//TODO oprimize
		for (i in 0..._layers.length) {
			if (priority < _layers[i].priority) {
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