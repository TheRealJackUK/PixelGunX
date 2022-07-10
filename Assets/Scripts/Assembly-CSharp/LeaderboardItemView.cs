using System;
using Rilisoft;
using UnityEngine;

internal sealed class LeaderboardItemView : MonoBehaviour
{
	private const string HighlightColor = "FFFF00";

	public UISprite rankSprite;

	public UILabel nicknameLabel;

	public UILabel winCountLabel;

	public UILabel placeLabel;

	public UITexture clanLogo;

	public void Reset(LeaderboardItemViewModel viewModel)
	{
		LeaderboardItemViewModel leaderboardItemViewModel = viewModel ?? LeaderboardItemViewModel.Empty;
		Func<object, string> func = delegate(object s)
		{
			string text = s.ToString();
			if (viewModel.Highlight)
			{
				text = string.Format("[{0}]{1}[-]", "FFFF00", text);
			}
			return text;
		};
		if (rankSprite != null)
		{
			rankSprite.spriteName = "Rank_" + Mathf.Clamp(leaderboardItemViewModel.Rank, 1, ExperienceController.maxLevel);
		}
		if (clanLogo != null)
		{
			if (!string.IsNullOrEmpty(leaderboardItemViewModel.ClanLogo))
			{
				try
				{
					byte[] data = Convert.FromBase64String(leaderboardItemViewModel.ClanLogo ?? string.Empty);
					Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoHeight, TextureFormat.ARGB32, false);
					texture2D.LoadImage(data);
					texture2D.filterMode = FilterMode.Point;
					texture2D.Apply();
					Texture mainTexture = clanLogo.mainTexture;
					clanLogo.mainTexture = texture2D;
					if (mainTexture != null)
					{
						UnityEngine.Object.Destroy(mainTexture);
					}
				}
				catch
				{
					Texture mainTexture2 = clanLogo.mainTexture;
					clanLogo.mainTexture = null;
					if (mainTexture2 != null)
					{
						UnityEngine.Object.Destroy(mainTexture2);
					}
				}
			}
			else
			{
				Texture mainTexture3 = clanLogo.mainTexture;
				clanLogo.mainTexture = null;
				if (mainTexture3 != null)
				{
					UnityEngine.Object.Destroy(mainTexture3);
				}
			}
		}
		if (nicknameLabel != null)
		{
			string arg = leaderboardItemViewModel.Nickname ?? string.Empty;
			nicknameLabel.text = func(arg);
		}
		if (winCountLabel != null)
		{
			winCountLabel.text = ((leaderboardItemViewModel != LeaderboardItemViewModel.Empty) ? func((leaderboardItemViewModel.WinCount != int.MinValue) ? Math.Max(leaderboardItemViewModel.WinCount, 0).ToString() : "—") : string.Empty);
		}
		if (placeLabel != null)
		{
			placeLabel.text = ((leaderboardItemViewModel != LeaderboardItemViewModel.Empty) ? func((leaderboardItemViewModel.Place >= 0) ? leaderboardItemViewModel.Place.ToString() : LocalizationStore.Key_0588) : string.Empty);
		}
	}

	public void Reset()
	{
		Reset(null);
	}
}
