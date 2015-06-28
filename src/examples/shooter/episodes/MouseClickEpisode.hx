package examples.shooter.episodes;
import cinema.Episode;
import cinema.Hunter;
import cinema.Story;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class MouseClickEpisode extends Episode
{
	private var _stage:Sprite;
	private var _isClicked:Bool = false;
	public function new(stage:Sprite) 
	{
		_stage = stage;
	}
	override function _initialize(story:Story):Void 
	{
		super._initialize(story);
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseClickHandler);
	}
	
	override function _destroy():Void 
	{
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseClickHandler);
		super._destroy();
	}
	
	private function mouseClickHandler(e:MouseEvent):Void 
	{
		_isClicked = true;
	}

}