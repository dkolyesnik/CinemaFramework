package cinema.roles;
import cinema.Role;
/**
 * ...
 * @author Kolyesnik D.V.
 */
class UpdatedRole extends Role implements IUpdatedRole
{

    public function new() 
    {
        super();
    }
	
	
	// ----- IUpdatedRole
	public function update(dt:Float):Void {
		
	}
	
	// ----- Model ------
	override function _roleConstructor():Role 
	{
		return new UpdatedRole();
	}
	
	
}