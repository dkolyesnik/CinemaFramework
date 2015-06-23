package cinema.filters;
import cinema.Tag;

/**
 * @author Kolyesnik D.V.
 */
interface IFilterSetup 
{
	function withTags(tags:Array<Tag>):IFilterSetup;
	
	function noTags(tags:Array<Tag>):IFilterSetup;
}