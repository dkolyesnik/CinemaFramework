package examples.shooter.episodes.misc;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class DelayEpisodeTimer extends EpisodeTimer
{
	private var _delay:Int;
	private var _count:Int;
	public function new(p_delay:Int) 
	{
		super();
		_delay = p_delay;
	}
	
	override public function start():Void 
	{
		_count = 0;
	}
	
	override public function check():Bool 
	{
		if (_count > _delay) {
			_count = 0;
			return true;
		}
		++_count;
		return false;
	}
	
}