package examples.test1;
import cinema.Hunter;
import cinema.properties.IntProperty;
import cinema.Role;
import cinema.Story;
import openfl.display.Sprite;
import cinema.Episode;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DrawEpisode extends Episode
{
	public var renderObjectHunter:Hunter<RenderRole>;
	
	public function new(main:Sprite) 
	{
		super();
		_spr = main;
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new RenderRole());
	}
	
	override function _createHunters() 
	{
		renderObjectHunter = new Hunter<RenderRole>(RenderRole.NAME);
	}
	
	override function _addHunters() 
	{
		_hunters.push( cast renderObjectHunter );
	}
	
	override public function update(dt:Float):Void 
	{
		_spr.graphics.clear();
		_spr.graphics.beginFill(0x004080);
		for (renderObject in renderObjectHunter) {
			_spr.graphics.drawCircle(renderObject.x, renderObject.y, renderObject.radius);
		}
		_spr.graphics.endFill();
	}
	
	
	private var _spr:Sprite;
}