using UnityEngine;

public class HockeyAppIOS : MonoBehaviour
{
	protected const string HOCKEYAPP_BASEURL = "https://rink.hockeyapp.net/";

	protected const string HOCKEYAPP_CRASHESPATH = "api/2/apps/[APPID]/crashes/upload";

	protected const int MAX_CHARS = 199800;

	protected const string LOG_FILE_DIR = "/logs/";

	public string appID = "your-hockey-app-id";

	public string secret = "your-hockey-app-secret";

	public string authenticationType = "your-auth-type";

	public string serverURL = "your-custom-server-url";

	public bool autoUpload;

	public bool exceptionLogging;

	public bool updateManager;
}
