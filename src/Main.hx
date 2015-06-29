package;

import cinema.properties.IntProperty;
import cinema.Story;
import examples.shooter.ShooterTest;
import examples.test1.DrawEpisode;
import examples.test1.MoveEpisode;
import examples.test1.RandomActionEpisode;
import examples.test1.Test1;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Main extends Sprite 
{
	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		var testsLayer:Sprite = new Sprite();
		
		//Tests
		addChild(createButton(100,100,"Test1",new Test1(testsLayer).start));
		addChild(createButton(100,200,"Shooter",new ShooterTest(testsLayer).start));
		
		
		
		addChild(testsLayer);
		
		
		addChild(new FPS(10, 10, 0xFFFF80));
	}
	
	private function createButton(posX:Float, posY:Float, label:String, handler:Dynamic->Void):Sprite {
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(0x0080FF);
		spr.graphics.drawRect( -50, -20, 100, 40);
		spr.graphics.endFill();
		var textField = new TextField();
		textField.text = label;
		textField.defaultTextFormat = new TextFormat ("_sans", 12, 0xFFFFFF);
		spr.addChild(textField);
		spr.addEventListener(MouseEvent.CLICK, handler);
		spr.x = posX;
		spr.y = posY;
		return spr;
	}
	
}
