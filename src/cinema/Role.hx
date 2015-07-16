package cinema;

/**
 * ...
 * @author Kolyesnik D.V.
 */
class Role implements IRoleModel
{
	public var actor:Actor;
	public var name(get, null):String;
	
	public function new() {	}
	
	public function checkRequirements(actor:Actor):Bool 
	{
		return true;
	}
	
	public function createRole(actor:Actor):Role 
	{
		return _roleConstructor()._initialize(actor);
	}
	
	private function _roleConstructor():Role 
	{
		return new Role();
	}
	
	private function get_name():String 
	{
		name = "Role";
	}
	//TODO как то ограничить вызов для ролей к-е в истории, возможно флагом к-й задаётся в Story
	public function initialize(p_actor:Actor):Void 
	{
		if (p_actor != null && checkRequirements(p_actor))
		{
			actor = p_actor;
			_readProperties();
		}
	}
	
	//TODO either remove either rename
	//@:allow(cinema.RoleDef)
	private function _initialize(p_actor:Actor):Role 
	{
		actor = p_actor;
		_readProperties();
		return this;
	}
	
	private function _readProperties():Void 
	{
		
	}
	
	//--------------------------------------------------------------
	//   vars
	//--------------------------------------------------------------
	
	private var _story:Story;
}