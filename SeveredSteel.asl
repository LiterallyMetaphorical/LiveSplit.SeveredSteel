state("ThankYouVeryCool-Win64-Shipping")
{
    int level     : 0x5219EA0;
    int menuState : 0x4F54688;
    int loading   : 0x521BBE4; // if this gets re-added in, make sure to also add it to init
    float IGT     : 0x0543C7F0, 0x118, 0xA18;
}

init
{
    vars.menuState = false;
    vars.totalGameTime = 0;
    vars.loading = 0;
    //vars.lastLevelLoaded = "";
}

startup
{
    vars.stopwatch = new Stopwatch();
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Severed Steel",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

start
{
    return (current.menuState == 7);
}

gameTime 
{
    return TimeSpan.FromSeconds(vars.totalGameTime + current.IGT);
}

update
{
    print(current.IGT.ToString());
}

isLoading
{
    return true;
}

exit
{
    timer.IsGameTimePaused = true;
}