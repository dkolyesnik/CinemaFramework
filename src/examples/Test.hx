package examples;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import cinema.Core;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Test
{
	private var _core:Core;
	private var _main:Sprite;
	private var _bg:Sprite;
	private var _layer:Sprite;
	private var _closeBtn:Sprite;
	
	public function new(main:Sprite) 
	{
		_main = main;
		
	}
	public function start(params:Dynamic):Void {
		_bg = new Sprite();
		_bg.graphics.beginFill(0x000000);
		_bg.graphics.drawRect(0, 0, 800, 600);
		_bg.graphics.endFill();
		_layer = new Sprite();
		_bg.addChild(_layer);
		_bg.addChild(_closeBtn = createCloseBtn());
		_main.addChild(_bg);
		_bg.addEventListener(Event.ENTER_FRAME, update);
		_core = new Core();
	}
	
	private function update(e:Event):Void 
	{
		_core.update(1);
	}
	
	private function close(event:Event):Void {
		_closeBtn.removeEventListener(MouseEvent.CLICK, close);
		_core.end();
		_bg.removeEventListener(Event.ENTER_FRAME, update);
		_bg.parent.removeChild(_bg);
	}
	
	private function createCloseBtn():Sprite {
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(0x0080FF);
		spr.graphics.drawRect( -50, -20, 100, 40);
		spr.graphics.endFill();
		var textField = new TextField();
		textField.text = "Back";
		textField.defaultTextFormat = new TextFormat ("_sans", 12, 0xFFFFFF);
		spr.addChild(textField);
		spr.addEventListener(MouseEvent.CLICK, close);
		spr.x = 800 - 120;
		spr.y = 40;
		return spr;
	}
}