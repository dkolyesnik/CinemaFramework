package examples.shooter.episodes;

import cinema.Episode;
import cinema.Hunter;
import cinema.Role;
import framework.common.roles.PositionRole;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class RemoveOnLeaveBorderEpisode extends Episode
{
	public var hunter:Hunter<PositionRole>;
	
	private var _leftBorder:Null<Float>;
	private var _rightBorder:Null<Float>;
	private var _topBorder:Null<Float>;
	private var _bottomBorder:Null<Float>;
	
	
	public function new(leftBorder:Null<Float> = null, rightBorder:Null<Float> = null, topBorder:Null<Float> = null , bottomBorder:Null<Float> = null) 
	{
		super();
		_leftBorder = leftBorder;
		_rightBorder = rightBorder;
		_topBorder = topBorder;
		_bottomBorder = bottomBorder;
	}
	
	override function _registerRoleModels() 
	{
		super._registerRoleModels();
		_story.registerRoleModel(new PositionRole());
	}
	
	override function _createHunters() 
	{
		super._createHunters();
		hunter = new Hunter<PositionRole>(PositionRole.NAME);
	}
	
	override function _addHunters() 
	{
		super._addHunters();
		
		_hunters.push( cast hunter );
	}
	
	override public function update(dt:Float):Void 
	{
		for (obj in hunter) {
			if ((_leftBorder != null && obj.x < _leftBorder) 
				|| (_rightBorder != null && obj.x > _rightBorder)
				|| (_topBorder != null && obj.y < _topBorder)
				|| (_bottomBorder != null && obj.y > _bottomBorder)) 
				{
					_story.markAsNeedToBeRemoved(obj.actor);					
				}
		}
	}
	
}