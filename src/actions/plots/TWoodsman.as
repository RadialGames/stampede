package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TWoodsman extends PlotPoint
	{
		
		public function TWoodsman() 
		{
			title = "Woodsman"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			var blueVal:Number = Game.stats.getStat(Config.STAT_BLUE);
			var redVal:Number = Game.stats.getStat(Config.STAT_RED);
			var brownVal:Number = Game.stats.getStat(Config.STAT_BROWN);
			var whiteVal:Number = Game.stats.getStat(Config.STAT_WHITE);
			
			if ( redVal >= 50 && blueVal >= 50 ) {
				//Game.stats.setStat(Game.stats.getStat(Config.STAT_RED), redVal + 30);
				outcomeDescription = "Arg is attacked by dogs! Arg is clever enough to throw a rock at the lead Dog";
			}
			
			if ( redVal >= 80 ) {
				Game.stats.setStat(Game.stats.getStat(Config.STAT_RED), redVal + 30);
				outcomeDescription = "Arg is attacked by dogs! Arg fights them off!";
			}
			
			if ( blueVal >= 80 ) {
				Game.stats.setStat(Game.stats.getStat(Config.STAT_BLUE), blueVal + 30);
				outcomeDescription = "Arg is attacked by dogs but pretends to be a Klar, they're natural enemy!";
			}
		}
	}

}