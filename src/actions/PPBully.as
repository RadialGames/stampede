package actions 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPBully extends PlotPoint
	{
		
		public function PPBully() 
		{
			title = "A bully attacks!"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName+ " beat up the bully!";
			outComeBool = true;
		}
	}

}