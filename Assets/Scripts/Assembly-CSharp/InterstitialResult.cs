internal sealed class InterstitialResult
{
	private readonly string _closeReason;

	private readonly string _errorMessage;

	public string CloseReason
	{
		get
		{
			return _closeReason;
		}
	}

	public string ErrorMessage
	{
		get
		{
			return _errorMessage;
		}
	}

	private InterstitialResult(string closeReason, string errorMessage)
	{
		_closeReason = closeReason ?? string.Empty;
		_errorMessage = errorMessage ?? string.Empty;
	}

	public static InterstitialResult FromCloseReason(string closeReason)
	{
		return new InterstitialResult(closeReason, string.Empty);
	}

	public static InterstitialResult FromErrorMessage(string errorMessage)
	{
		return new InterstitialResult(string.Empty, errorMessage);
	}
}
