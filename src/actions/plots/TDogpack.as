package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TDogpack extends PlotPoint
	{
		
		public function TDogpack() 
		{
			title = "Dogpack"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			var blueVal:Number = Game.stats.getStat(Config.STAT_BLUE);
			var redVal:Number = Game.stats.getStat(Config.STAT_RED);
			
			if ( redVal >= 50 && blueVal >= 50 ) {
				//Game.stats.setStat(Game.stats.getStat(Config.STAT_RED), redVal + 30);
				outcomeDescription = "Arg is attacked by dogs! Arg is clever enough to throw a rock at the lead Dog";
				return;
			}
			
			if ( redVal >= 80 ) {
				Game.stats.setStat(Game.stats.getStat(Config.STAT_RED), redVal + 40);
				outcomeDescription = "Arg is attacked by dogs! Arg fights them off!";
				return;
			}
			
			if ( blueVal >= 80 ) {
				Game.stats.setStat(Game.stats.getStat(Config.STAT_BLUE), blueVal + 40);
				outcomeDescription = "Arg is attacked by dogs but pretends to be a Klar, they're natural enemy!";
				return;
			}
			
			outcomeDescription = "Arg is savaged by a pack of dogs!";
			Game.stats.setStat(Game.stats.getStat(Config.STAT_RED), redVal+ 40);
			return;
		}
	}

}