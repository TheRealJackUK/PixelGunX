using System;
using UnityEngine;
using UnityEngine.SocialPlatforms;

public class AGSSocialAchievement : IAchievementDescription, IAchievement
{
	public readonly AGSAchievement achievement;

	public string id { get; set; }

	public double percentCompleted { get; set; }

	public bool completed
	{
		get
		{
			return achievement.isUnlocked;
		}
	}

	public bool hidden
	{
		get
		{
			return achievement.isHidden;
		}
	}

	public DateTime lastReportedDate
	{
		get
		{
			return achievement.dateUnlocked;
		}
	}

	public string title
	{
		get
		{
			return achievement.title;
		}
	}

	public Texture2D image
	{
		get
		{
			AGSClient.LogGameCircleError("IAchievementDescription.image.get is not available for GameCircle");
			return null;
		}
	}

	public string achievedDescription
	{
		get
		{
			return achievement.description;
		}
	}

	public string unachievedDescription
	{
		get
		{
			return achievement.description;
		}
	}

	public int points
	{
		get
		{
			return achievement.pointValue;
		}
	}

	public AGSSocialAchievement(AGSAchievement achievement)
	{
		if (achievement == null)
		{
			AGSClient.LogGameCircleError("AGSSocialAchievement constructor \"achievement\" argument should not be null");
			achievement = AGSAchievement.GetBlankAchievement();
		}
		else
		{
			this.achievement = achievement;
		}
		id = achievement.id;
		percentCompleted = achievement.progress;
	}

	public AGSSocialAchievement()
	{
		achievement = AGSAchievement.GetBlankAchievement();
	}

	public void ReportProgress(Action<bool> callback)
	{
		GameCircleSocial.Instance.ReportProgress(id, percentCompleted, callback);
	}
}
