using System;
using UnityEngine;

namespace Rilisoft
{
	public class Tools
	{
		public static int AllWithoutDamageCollidersMask
		{
			get
			{
				return -5 & ~(1 << LayerMask.NameToLayer("DamageCollider"));
			}
		}

		public static int AllAvailabelBotRaycastMask
		{
			get
			{
				return -5 & ~(1 << LayerMask.NameToLayer("DamageCollider")) & ~(1 << LayerMask.NameToLayer("NotDetectMobRaycast"));
			}
		}

		public static bool ParseDateTimeFromPlayerPrefs(string dateKey, out DateTime parsedDate)
		{
			string @string = Storager.getString(dateKey, false);
			return DateTime.TryParse(@string, out parsedDate);
		}

		public static DateTime GetCurrentTimeByUnixTime(int unixTime)
		{
			return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(unixTime);
		}

		public static void AddSessionNumber()
		{
			int @int = PlayerPrefs.GetInt(Defs.SessionNumberKey, 1);
			PlayerPrefs.SetInt(Defs.SessionNumberKey, @int + 1);
			string @string = PlayerPrefs.GetString(Defs.LastTimeSessionDayKey, string.Empty);
			DateTimeOffset result;
			DateTimeOffset.TryParse(DateTimeOffset.UtcNow.ToString("s"), out result);
			DateTimeOffset result2;
			if (string.IsNullOrEmpty(@string) || (DateTimeOffset.TryParse(@string, out result2) && ((!Defs.IsDeveloperBuild && (result - result2).TotalHours > 23.0) || (Defs.IsDeveloperBuild && (result - result2).TotalMinutes > 3.0))))
			{
				int int2 = PlayerPrefs.GetInt(Defs.SessionDayNumberKey, 0);
				PlayerPrefs.SetInt(Defs.SessionDayNumberKey, int2 + 1);
				PlayerPrefs.SetString(Defs.LastTimeSessionDayKey, DateTimeOffset.UtcNow.ToString("s"));
			}
		}
	}
}
