using System;

public class AuthenticationValues
{
	public CustomAuthenticationType AuthType = CustomAuthenticationType.None;

	public string AuthGetParameters;

	public string Token;

	public object AuthPostData { get; private set; }

	public string UserId { get; set; }

	public AuthenticationValues()
	{
	}

	public AuthenticationValues(string userId)
	{
		UserId = userId;
	}

	public virtual void SetAuthPostData(string stringData)
	{
		AuthPostData = ((!string.IsNullOrEmpty(stringData)) ? stringData : null);
	}

	public virtual void SetAuthPostData(byte[] byteData)
	{
		AuthPostData = byteData;
	}

	public virtual void AddAuthParameter(string key, string value)
	{
		string text = ((!string.IsNullOrEmpty(AuthGetParameters)) ? "&" : string.Empty);
		AuthGetParameters = string.Format("{0}{1}{2}={3}", AuthGetParameters, text, Uri.EscapeDataString(key), Uri.EscapeDataString(value));
	}

	public override string ToString()
	{
		return string.Format("AuthenticationValues UserId: {0}, GetParameters: {1} Token available: {2}", UserId, AuthGetParameters, Token != null);
	}
}
