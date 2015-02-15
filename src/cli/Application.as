package cli
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.InvokeEvent;
    import flash.events.UncaughtErrorEvent;

	/**
	 *  @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")]

	/**
	 *  @eventType flash.events.ErrorEvent.ERROR
	 */
	[Event(name="error", type="flash.events.ErrorEvent")]


	/**
	 * @version $Id$
	 */
	public class Application extends Sprite
	{
		protected function usage():void
		{
			trace("Usage:");
			trace("  --help:  show usage");
		}

		protected var args:Array;

		public function Application()
		{
            NativeApplication.nativeApplication.autoExit = false;
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, invokeHandler);
		}

		private function invokeHandler(event:InvokeEvent):void
		{
			event.target.removeEventListener(InvokeEvent.INVOKE, invokeHandler);
			args = event.arguments;

			addEventListener(ErrorEvent.ERROR, function (e:ErrorEvent):void {
				trace('ERROR: '+ e.toString());
				NativeApplication.nativeApplication.exit(1);
			});

			if (args.length > 0 && args[0] == "--help") {
				usage();
				return exit();
			}

            // Catch uncaught errors
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,
                function(e:UncaughtErrorEvent):void {
                    e.preventDefault();
                    trace(e.error.getStackTrace());
                    exit(1);
                });

            // Run
			try {
				execute();
			} catch(e:Error) {
				error(e.toString());
			}

            // Why?
            addChild(new Sprite());
		}

		/** */
		protected function execute():void
		{
			error('You must to override execute');
		}

		public function exit(status:int = 0):void
		{
            var exitingEvent:Event = new Event(Event.EXITING, false, true);
            NativeApplication.nativeApplication.dispatchEvent(exitingEvent);
            if (!exitingEvent.isDefaultPrevented()) {
                NativeApplication.nativeApplication.exit(status);
            }
		}

		public function error(message:String):void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
		}
	}
}
