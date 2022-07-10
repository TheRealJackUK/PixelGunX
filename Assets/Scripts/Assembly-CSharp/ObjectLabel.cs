using System;
using UnityEngine;

[RequireComponent(typeof(GUIText))]
public class ObjectLabel : MonoBehaviour
{
	public static Camera currentCamera;

	public Transform target;

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

	private Transform camTransform;

	private ExperienceController expController;

	private bool isSetColor;

	public WeaponManager _weaponManager;

	private int rank = 1;

	private float koofScreen = (float)Screen.height / 768f;

	private HungerGameController hungerGameController;

	private bool isHunger;

	private bool isCompany;

	public GUITexture clanTexture;

	public GUIText clanName;

	private void Start()
	{
		_weaponManager = WeaponManager.sharedManager;
		isHunger = Defs.isHunger;
		if (isHunger && GameObject.FindGameObjectWithTag("HungerGameController") != null)
		{
			hungerGameController = GameObject.FindGameObjectWithTag("HungerGameController").GetComponent<HungerGameController>();
		}
		expController = GameObject.FindGameObjectWithTag("ExperienceController").GetComponent<ExperienceController>();
		float num = 36f * Defs.Coef;
		thisTransform = base.transform;
		cam = currentCamera;
		camTransform = cam.transform;
		base.transform.GetComponent<GUITexture>().pixelInset = new Rect(-75f * koofScreen, -3f * koofScreen, 30f * koofScreen, 30f * koofScreen);
		base.transform.GetComponent<GUIText>().pixelOffset = new Vector2(-45f * koofScreen, 0f);
		base.transform.GetComponent<GUIText>().fontSize = Mathf.RoundToInt(20f * koofScreen);
		isCompany = Defs.isCompany;
		clanTexture.pixelInset = new Rect(-64f * koofScreen, -18f * koofScreen, 15f * koofScreen, 15f * koofScreen);
		clanName.pixelOffset = new Vector2(-41f * koofScreen, -4f);
		clanName.fontSize = Mathf.RoundToInt(16f * koofScreen);
	}

	public void ResetTimeShow()
	{
		timeShow = 1f;
	}

	private void Update()
	{
		if (timeShow > 0f)
		{
			timeShow -= Time.deltaTime;
		}
		if (target == null || cam == null)
		{
			Debug.Log("target == null || cam == null");
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		if ((isHunger && hungerGameController != null && !hungerGameController.isGo) || _weaponManager.myPlayer == null)
		{
			ResetTimeShow();
		}
		if ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints) && _weaponManager.myPlayer != null && _weaponManager.myPlayerMoveC != null && target.GetComponent<Player_move_c>() != null && _weaponManager.myPlayerMoveC.myCommand == target.GetComponent<Player_move_c>().myCommand)
		{
			ResetTimeShow();
		}
		try
		{
			cam = currentCamera;
			camTransform = cam.transform;
			GUITexture component = base.transform.GetComponent<GUITexture>();
			if (component == null)
			{
				Debug.LogError("guiTexture == null");
				return;
			}
			if (!isMenu)
			{
				Player_move_c component2 = target.GetComponent<Player_move_c>();
				if (!isSetColor)
				{
					if (component2.myCommand == 1)
					{
						base.gameObject.GetComponent<GUIText>().color = Color.blue;
						isSetColor = true;
					}
					if (component2.myCommand == 2)
					{
						base.gameObject.GetComponent<GUIText>().color = Color.red;
						isSetColor = true;
					}
				}
				int myRanks = component2.myTable.GetComponent<NetworkStartTable>().myRanks;
				if (myRanks < 0 || myRanks >= expController.marks.Length)
				{
					string message = string.Format("Rank is equal to {0}, but the range [0, {1}) expected.", myRanks, expController.marks.Length);
					Debug.LogError(message);
				}
				else
				{
					component.texture = expController.marks[myRanks];
				}
				clanTexture.texture = component2.myTable.GetComponent<NetworkStartTable>().myClanTexture;
				clanName.text = component2.myTable.GetComponent<NetworkStartTable>().myClanName;
			}
			else
			{
				component.pixelInset = new Rect(-130f * koofScreen, -6f * koofScreen, 36f * koofScreen, 36f * koofScreen);
				base.transform.GetComponent<GUIText>().pixelOffset = new Vector2(-85f * koofScreen, 0f);
				base.transform.GetComponent<GUIText>().fontSize = Mathf.RoundToInt(20f * Defs.Coef);
				offset = new Vector3(0f, 2.25f, 0f);
				component.texture = expController.marks[expController.currentLevel];
				clanTexture.pixelInset = new Rect(-110f * koofScreen, -18f * koofScreen, 15f * koofScreen, 15f * koofScreen);
				clanName.pixelOffset = new Vector2(-85f * koofScreen, -2f);
				clanName.fontSize = Mathf.RoundToInt(16f * koofScreen);
				if (clanTexture.texture == null)
				{
					if (!string.IsNullOrEmpty(FriendsController.sharedController.clanLogo))
					{
						byte[] data = Convert.FromBase64String(FriendsController.sharedController.clanLogo);
						Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoWidth);
						texture2D.LoadImage(data);
						texture2D.filterMode = FilterMode.Point;
						texture2D.Apply();
						clanTexture.texture = texture2D;
					}
					else
					{
						clanTexture.texture = null;
					}
					clanName.text = FriendsController.sharedController.clanName;
				}
			}
			if (timeShow > 0f)
			{
				posLabel = cam.WorldToViewportPoint(target.position + offset);
			}
			if (timeShow > 0f && posLabel.z >= 0f)
			{
				thisTransform.position = posLabel;
			}
			else
			{
				thisTransform.position = new Vector3(-1000f, -1000f, -1000f);
			}
			if (!isMenu && target.transform.parent.transform.position.y < -1000f)
			{
				thisTransform.position = new Vector3(-1000f, -1000f, -1000f);
			}
		}
		catch (Exception ex)
		{
			Debug.Log("Exception in ObjectLabel: " + ex);
		}
	}
}
