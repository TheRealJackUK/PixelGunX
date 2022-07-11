using System;
using UnityEngine;

public sealed class NickLabelController : MonoBehaviour
{
	private const string RankSpriteNameBase = "Rank_";

	private Vector3 offsetMech = new Vector3(0f, 0.5f, 0f);

	public GameObject expFrameLobby;

	public UISprite expProgressSprite;

	public UILabel expLabel;

	public UISprite ranksSpriteForLobby;

	private int expBound;

	private int expXp;

	private int expRank;

	public bool isPointLabel;

	public UISprite pointSprite;

	public UISprite pointFillSprite;

	public GameObject nickObj;

	public GameObject isEnemySprite;

	public GameObject placeMarker;

	public static Camera currentCamera;

	public Camera _currentCamera;

	public Transform target;

	public Player_move_c playerScript;

	public Vector3 offset = Vector3.up;

	public bool clampToScreen;

	public float clampBorderSize = 0.05f;

	public bool useMainCamera = true;

	public Camera cameraToUse;

	public Camera cam;

	public float timeShow;

	public Vector3 posLabel;

	public bool isShow;

	public bool isMenu;

	public bool isShadow;

	private Transform thisTransform;

	private ExperienceController expController;

	public bool isSetColor;

	private int rank = 1;

	private float koofScreen = (float)Screen.height / 768f;

	public UITexture clanTexture;

	public UILabel clanName;

	public GameObject healthObj;

	public UISprite healthSprite;

	private int maxHeathWidth = 134;

	public UISprite multyKill;

	public float timerShowMyltyKill;

	public float maxTimerShowMultyKill = 5f;

	public UILabel nickLabel;

	public UISprite rankTexture;

	public bool isVisible;

	public UILabel freeAwardTitle;

	public bool inShop;

	public bool isUse;

	public bool isSetInfo;

	public bool isTurrerLabel;

	public float minScale = 0.6f;

	public float minDist = 10f;

	public float maxDist = 30f;

	public void ShowMultyKill(int stateMulty)
	{
		if (stateMulty > 1)
		{
			multyKill.spriteName = "kill_" + (stateMulty - 1);
			timerShowMyltyKill = maxTimerShowMultyKill;
		}
		else
		{
			timerShowMyltyKill = -1f;
		}
	}

	private void Start()
	{
		thisTransform = base.transform;
		if (!inShop)
		{
			thisTransform.localPosition = new Vector3(-10000f, -10000f, -10000f);
		}
	}

	private void UpdateExpFrameInLobby()
	{
		expRank = ExperienceController.sharedController.currentLevel;
		ranksSpriteForLobby.spriteName = "Rank_" + expRank;
		expBound = ExperienceController.MaxExpLevels[ExperienceController.sharedController.currentLevel];
		expXp = Mathf.Clamp(ExperienceController.sharedController.CurrentExperience, 0, expBound);
		string text = string.Format("{0} {1}/{2}", LocalizationStore.Get("Key_0204"), expXp, expBound);
		if (ExperienceController.sharedController.currentLevel == ExperienceController.maxLevel)
		{
			text = LocalizationStore.Get("Key_0928");
		}
		expLabel.text = text;
		expProgressSprite.width = Mathf.RoundToInt(146f * ((ExperienceController.sharedController.currentLevel != ExperienceController.maxLevel) ? ((float)expXp / (float)expBound) : 1f));
	}

	public void StartShow()
	{
		base.gameObject.SetActive(true);
		isUse = true;
		isSetColor = false;
		isSetInfo = false;
		nickLabel.color = Color.white;
		placeMarker.SetActive(false);
		isEnemySprite.SetActive(false);
		multyKill.gameObject.SetActive(false);
		clanTexture.mainTexture = null;
		clanName.text = string.Empty;
		clanName.gameObject.SetActive(true);
		healthObj.SetActive(false);
		rankTexture.gameObject.SetActive(false);
		freeAwardTitle.gameObject.SetActive(false);
		healthSprite.enabled = true;
		if (isMenu)
		{
			rankTexture.gameObject.SetActive(false);
			float num = 1.3f;
			thisTransform.localScale = new Vector3(num, num, num);
			expFrameLobby.SetActive(true);
			UpdateExpFrameInLobby();
		}
		else
		{
			expFrameLobby.SetActive(false);
		}
		if (isPointLabel)
		{
			rankTexture.gameObject.SetActive(false);
			nickLabel.gameObject.SetActive(false);
			pointSprite.gameObject.SetActive(true);
		}
		else
		{
			nickLabel.gameObject.SetActive(true);
			pointSprite.gameObject.SetActive(false);
		}
		if (isMenu || inShop)
		{
			UpdaeData();
			return;
		}
		if (!isTurrerLabel)
		{
			if (!isPointLabel)
			{
				offset = new Vector3(0f, 0.6f, 0f);
			}
			else
			{
				offset = new Vector3(0f, 2.25f, 0f);
			}
			healthObj.SetActive(false);
		}
		else
		{
			offset = new Vector3(0f, 1.76f, 0f);
			healthObj.SetActive(true);
		}
		thisTransform.localPosition = new Vector3(-10000f, -10000f, -10000f);
	}

	private void UpdateRankSprite()
	{
		rankTexture.spriteName = "Rank_" + ExperienceController.sharedController.currentLevel;
		Transform transform = rankTexture.transform;
		transform.localPosition = new Vector3((float)(-nickLabel.width) * 0.5f - 20f, transform.localPosition.y, transform.localPosition.z);
	}

	public void UpdaeData()
	{
		offset = new Vector3(0f, 2.26f, 0f);
		string text = FilterBadWorld.FilterString(Defs.GetPlayerNameOrDefault());
		if (nickLabel.text != text)
		{
			nickLabel.text = text;
		}
		UpdateRankSprite();
		clanName.text = FriendsController.sharedController.clanName;
		if (!string.IsNullOrEmpty(FriendsController.sharedController.clanLogo))
		{
			byte[] data = Convert.FromBase64String(FriendsController.sharedController.clanLogo);
			Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoWidth);
			texture2D.LoadImage(data);
			texture2D.filterMode = FilterMode.Point;
			texture2D.Apply();
			clanTexture.mainTexture = texture2D;
			Transform transform = clanTexture.transform;
			transform.localPosition = new Vector3((float)(-clanName.width) * 0.5f - 16f, transform.localPosition.y, transform.localPosition.z);
		}

		else
		{
			clanTexture.mainTexture = null;
		}
	}

	public void OnEnable()
	{
		if (inShop)
		{
			UpdaeData();
		}
	}

	public void ResetTimeShow()
	{
		timeShow = 0.1f;
	}

	public void LateUpdate()
	{
		if (inShop)
		{
			if (rankTexture != null && rankTexture.spriteName != null && ExperienceController.sharedController != null && !rankTexture.spriteName.Substring("Rank_".Length).Equals(ExperienceController.sharedController.currentLevel.ToString()))
			{
				UpdateRankSprite();
			}
			return;
		}
		if (target == null || currentCamera == null)
		{
			if (isPointLabel && currentCamera == null)
			{
				thisTransform.localPosition = new Vector3(-10000f, -10000f, -10000f);
				return;
			}
			isTurrerLabel = false;
			if (thisTransform.position.y > -5000f)
			{
				thisTransform.position = new Vector3(-10000f, -10000f, -10000f);
			}
			isUse = false;
			isMenu = false;
			isPointLabel = false;
			base.gameObject.SetActive(false);
			return;
		}
		if (isMenu)
		{
			UpdateExpFrameInLobby();
		}
		if (timerShowMyltyKill > 0f)
		{
			timerShowMyltyKill -= Time.deltaTime;
		}
		bool flag = timerShowMyltyKill > 0f && isVisible;
		if (multyKill.gameObject.activeSelf != flag)
		{
			multyKill.gameObject.SetActive(flag);
		}
		if (timeShow > 0f)
		{
			timeShow -= Time.deltaTime;
		}
		if ((Defs.isHunger && HungerGameController.Instance != null && !HungerGameController.Instance.isGo) || WeaponManager.sharedManager.myPlayer == null)
		{
			ResetTimeShow();
		}
		if (WeaponManager.sharedManager.myPlayerMoveC != null && WeaponManager.sharedManager.myPlayerMoveC.isKilled)
		{
			ResetTimeShow();
		}
		if (isPointLabel)
		{
			if (target.GetComponent<BasePointController>() != null && target.GetComponent<BasePointController>().isBaseActive)
			{
				ResetTimeShow();
			}
			else
			{
				timeShow = 0f;
			}
		}
		if ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints) && WeaponManager.sharedManager.myPlayer != null && WeaponManager.sharedManager.myPlayerMoveC != null && target.GetComponent<Player_move_c>() != null && WeaponManager.sharedManager.myPlayerMoveC.myCommand == target.GetComponent<Player_move_c>().myCommand)
		{
			ResetTimeShow();
		}
		if (ShopNGUIController.sharedShop != null && !ShopNGUIController.GuiActive)
		{
			if (timeShow > 0f || flag || (playerScript != null && playerScript.isPlacemarker && isVisible))
			{
				posLabel = currentCamera.WorldToViewportPoint(target.position + offset + ((!(playerScript != null) || !playerScript.isMechActive) ? Vector3.zero : offsetMech));
			}
			if ((!(timeShow > 0f) && !flag && (!(playerScript != null) || !playerScript.isPlacemarker || !isVisible)) || !(posLabel.z >= 0f))
			{
				thisTransform.localPosition = new Vector3(-10000f, -10000f, -10000f);
				return;
			}
			thisTransform.localPosition = new Vector3((posLabel.x - 0.5f) * (float)Screen.width / (float)Screen.height * 768f, (posLabel.y - 0.5f) * 768f, 0f);
			if (!isMenu && !isTurrerLabel && target.transform.parent.transform.position.y < -1000f)
			{
				thisTransform.localPosition = new Vector3(-10000f, -10000f, -10000f);
				return;
			}
		}
		if (!isMenu)
		{
			float num = 1f;
			if (WeaponManager.sharedManager.myPlayerMoveC != null && !WeaponManager.sharedManager.myPlayerMoveC.isKilled)
			{
				float num2 = Vector3.Magnitude(target.position - WeaponManager.sharedManager.myPlayerMoveC.myTransform.position);
				if (num2 < minDist)
				{
					num2 = minDist;
				}
				if (num2 > maxDist)
				{
					num2 = maxDist;
				}
				num = 1f - 0.5f * (num2 - minDist) / (maxDist - minDist);
			}
			if (isPointLabel)
			{
				num *= 2f;
			}
			thisTransform.localScale = new Vector3(num, num, num);
		}
		if (!isMenu && !isTurrerLabel && !isPointLabel)
		{
			if (!isSetColor)
			{
				if (playerScript.myCommand == 1)
				{
					nickLabel.color = Color.blue;
					isSetColor = true;
				}
				if (playerScript.myCommand == 2)
				{
					nickLabel.color = Color.red;
					isSetColor = true;
				}
			}
			if (playerScript.isPlacemarker != placeMarker.activeSelf)
			{
				placeMarker.SetActive(playerScript.isPlacemarker);
			}
		}
		if (isMenu || !isTurrerLabel || isPointLabel)
		{
			return;
		}
		TurretController component = target.GetComponent<TurretController>();
		SkinName skinName = ((!(component.myPlayer != null)) ? null : component.myPlayer.GetComponent<SkinName>());
		Player_move_c player_move_c = ((!(skinName != null)) ? null : skinName.playerMoveC);
		if (!isSetColor && player_move_c != null && (Defs.isCompany || Defs.isFlag || Defs.isCapturePoints))
		{
			int myCommand = player_move_c.myCommand;
			if (myCommand == 1)
			{
				nickLabel.color = Color.blue;
				isSetColor = true;
			}
			if (myCommand == 2)
			{
				nickLabel.color = Color.red;
				isSetColor = true;
			}
		}
		if (skinName != null && nickLabel != null && skinName.NickName != nickLabel.text)
		{
			nickLabel.text = skinName.NickName;
		}
		if (!Defs.isMulti && !isPointLabel)
		{
			string text = FilterBadWorld.FilterString(Defs.GetPlayerNameOrDefault());
			if (text != nickLabel.text)
			{
				nickLabel.text = FilterBadWorld.FilterString(Defs.GetPlayerNameOrDefault());
			}
		}
		float num3 = Mathf.RoundToInt((float)maxHeathWidth * (((!(component.health < 0f)) ? component.health : 0f) / component.maxHealth));
		if (num3 < 0.1f)
		{
			num3 = 0f;
			healthSprite.enabled = false;
		}
		healthSprite.width = Mathf.RoundToInt(num3);
	}
}
