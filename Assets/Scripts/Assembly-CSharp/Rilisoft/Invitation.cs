using System;
using System.Collections.Generic;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class Invitation : MonoBehaviour
	{
		public UILabel nm;

		public GameObject accept;

		public GameObject reject;

		public GameObject JoinClan;

		public GameObject RejectClan;

		public GameObject youAlready;

		public UISprite rank;

		public string id;

		public string recordId;

		private float timeLastCheck;

		public bool outgoing;

		public bool IsClanInv;

		public UITexture ClanLogo;

		public string clanLogoString;

		private float inactivityStartTm;

		private void Start()
		{
			inactivityStartTm = float.PositiveInfinity;
			_UpdateInfo();
			if (JoinClan != null)
			{
				JoinClan.SetActive(IsClanInv && string.IsNullOrEmpty(FriendsController.sharedController.ClanID) && string.IsNullOrEmpty(FriendsController.sharedController.JoinClanSent));
			}
			if (RejectClan != null)
			{
				RejectClan.SetActive(IsClanInv);
			}
			if (youAlready != null)
			{
				youAlready.SetActive(IsClanInv && !string.IsNullOrEmpty(FriendsController.sharedController.ClanID));
			}
			if (ClanLogo != null)
			{
				ClanLogo.gameObject.SetActive(IsClanInv);
			}
			if (accept != null)
			{
				accept.SetActive(!IsClanInv);
			}
			reject.SetActive(!IsClanInv);
			rank.gameObject.SetActive(!IsClanInv);
		}

		public void KeepClanData()
		{
			FriendsController.sharedController.tempClanID = id;
			FriendsController.sharedController.tempClanLogo = clanLogoString ?? string.Empty;
			FriendsController.sharedController.tempClanName = nm.text ?? string.Empty;
		}

		private void _UpdateInfo()
		{
			if (IsClanInv)
			{
				foreach (Dictionary<string, string> clanInvite in FriendsController.sharedController.ClanInvites)
				{
					string value;
					if (clanInvite.TryGetValue("id", out value) && value.Equals(id))
					{
						string value2;
						if (clanInvite.TryGetValue("logo", out value2))
						{
							try
							{
								byte[] data = Convert.FromBase64String(value2);
								Texture2D texture2D = new Texture2D(8, 8, TextureFormat.ARGB32, false);
								texture2D.LoadImage(data);
								texture2D.filterMode = FilterMode.Point;
								texture2D.Apply();
								Texture mainTexture = ClanLogo.mainTexture;
								ClanLogo.mainTexture = texture2D;
								if (mainTexture != null)
								{
									UnityEngine.Object.Destroy(mainTexture);
								}
							}
							catch (Exception)
							{
								Texture mainTexture2 = ClanLogo.mainTexture;
								ClanLogo.mainTexture = null;
								if (mainTexture2 != null)
								{
									UnityEngine.Object.Destroy(mainTexture2);
								}
							}
						}
						string value3;
						if (clanInvite.TryGetValue("name", out value3))
						{
							nm.text = value3;
						}
						break;
					}
				}
				return;
			}
			Dictionary<string, object> value4;
			object value5;
			if (id != null && FriendsController.sharedController.playersInfo.TryGetValue(id, out value4) && value4.TryGetValue("player", out value5))
			{
				nm.text = (value5 as Dictionary<string, object>)["nick"] as string;
				string text = (value5 as Dictionary<string, object>)["rank"] as string;
				rank.spriteName = "Rank_" + ((!text.Equals("0")) ? text : "1");
			}
		}

		public void DisableButtons()
		{
			if (accept != null)
			{
				accept.SetActive(false);
			}
			reject.SetActive(false);
			inactivityStartTm = Time.realtimeSinceStartup;
			if (JoinClan != null)
			{
				JoinClan.SetActive(false);
			}
			if (RejectClan != null)
			{
				RejectClan.SetActive(false);
			}
		}

		private void Update()
		{
			if (Time.realtimeSinceStartup - inactivityStartTm > 15f)
			{
				inactivityStartTm = float.PositiveInfinity;
				if (accept != null)
				{
					accept.SetActive(true);
				}
				reject.SetActive(!IsClanInv);
				if (JoinClan != null)
				{
					JoinClan.SetActive(IsClanInv && string.IsNullOrEmpty(FriendsController.sharedController.ClanID) && string.IsNullOrEmpty(FriendsController.sharedController.JoinClanSent));
				}
				if (RejectClan != null)
				{
					RejectClan.SetActive(!IsClanInv);
				}
				if (youAlready != null)
				{
					youAlready.SetActive(IsClanInv && !string.IsNullOrEmpty(FriendsController.sharedController.ClanID));
				}
			}
			if (Time.realtimeSinceStartup - timeLastCheck > 1f)
			{
				timeLastCheck = Time.realtimeSinceStartup;
				_UpdateInfo();
			}
		}
	}
}
