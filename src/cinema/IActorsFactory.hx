package cinema;

/**
 * @author Kolyesnik D.V.
 */
interface IActorsFactory 
{
	//TODO возможно как-то переделать чтобы не передавать стори
	function setStory(story:Story):Void;
	function removeStory():Void;
	function create(type:String, name:String = ""):Actor;
}