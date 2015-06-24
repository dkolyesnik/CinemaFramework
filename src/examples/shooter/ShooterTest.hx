package examples.shooter;

import cinema.Core;
import examples.Test;
import examples.test1.DrawProcess;
import openfl.display.Sprite;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class ShooterTest extends Test
{

	public function new(main:Sprite) 
	{
		super(main);
		
	}
	
	override public function start(params:Dynamic):Void 
	{
		super.start(params);
		
		var drawProcess = new DrawProcess(_layer);
		_core.addProcess(drawProcess);
		
		
		
	}
	
	
}