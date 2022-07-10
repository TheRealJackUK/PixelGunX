public class AGSRequestResponse
{
	protected const string PLATFORM_NOT_SUPPORTED_ERROR = "PLATFORM_NOT_SUPPORTED";

	protected const string JSON_PARSE_ERROR = "ERROR_PARSING_JSON";

	public string error;

	public int userData;

	public bool IsError()
	{
		return !string.IsNullOrEmpty(error);
	}
}
