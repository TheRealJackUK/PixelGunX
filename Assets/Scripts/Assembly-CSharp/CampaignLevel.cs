using UnityEngine;

public sealed class CampaignLevel
{
	public float timeToComplete = 300f;

	private Vector3 _localPosition = Vector3.forward;

	private string _sceneName;

	public string sceneName
	{
		get
		{
			return _sceneName;
		}
		set
		{
			_sceneName = value;
		}
	}

	public Vector3 LocalPosition
	{
		get
		{
			return _localPosition;
		}
		set
		{
			_localPosition = value;
		}
	}

	public CampaignLevel(string sceneName)
	{
		_sceneName = sceneName;
	}

	public CampaignLevel()
	{
		_sceneName = string.Empty;
	}
}
