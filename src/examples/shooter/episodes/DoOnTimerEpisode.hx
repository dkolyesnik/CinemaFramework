package examples.shooter.episodes;

import cinema.Episode;
import cinema.Story;
import examples.shooter.episodes.misc.EpisodeTimer;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DoOnTimerEpisode extends Episode
{
	private var _timer:EpisodeTimer;
	
	private var _handler:Void->Void;
	
	public function new() 
	{
		super();
		
	}
	
	public function setTimer(timer:EpisodeTimer):DoOnTimerEpisode {
		_timer = timer;
		return this;
	}
	
	public function setHandler(handler:Void->Void):DoOnTimerEpisode {
		_handler = handler;
		return this;
	}
	
	override function _initialize(story:Story):Void 
	{
		super._initialize(story);
		if (_timer != null) {
			_timer.start();
		}else {
			//TODO error
			trace("DoOnTimerEpisode timer is not set");
		}
		if (_handler == null) {
			//TODO error
			trace("DoOnTimerEpisode handler is not set");
		}
	}
	
	override function _destroy():Void 
	{
		super._destroy();
		if (_timer != null) {
			_timer.stop();
		}
 	}
	
	override public function update(dt:Float):Void 
	{
		if (_timer.check()) {
			_handler();
		}
	}
	
	
}