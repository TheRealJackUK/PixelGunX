using engine.unity;

namespace engine.helpers
{
	public class Log : MonoSingleton<Log>
	{
		public bool ShowFilters;
		public bool syncLogs;
		public bool InPlaceLog;
		public bool OpenLogByError;
	}
}
