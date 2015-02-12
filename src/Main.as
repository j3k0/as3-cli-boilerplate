package
{
    import cli.Application;
    import flash.utils.setTimeout;

	public class Main extends Application
	{
		override protected function usage():void
		{
			super.usage();
			trace("  <file name>");
		}

        override protected function execute():void
        {
            trace("  here I am");
            setTimeout(function():void { exit(0); }, 1000);
        }
	}
}
