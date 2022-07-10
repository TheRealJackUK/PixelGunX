using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Holoville.HOTween.Plugins;
using Rilisoft;
using UnityEngine;

internal sealed class FriendProfileView : MonoBehaviour
{
	private enum State
	{
		Idle,
		Chatting
	}

	public Transform pers;

	public GameObject[] bootsPoint;

	public GameObject capePoint;

	public GameObject armorPoint;

	public GameObject hatPoint;

	public GameObject characterModel;

	public GameObject armorLeftPl;

	public GameObject armorRightPl;

	public UIButton backButton;

	public UIButton joinButton;

	public UIButton messageButton;

	public UISprite chatForeground;

	public UISprite rankSprite;

	public UILabel onlineLab;

	public UILabel offline;

	public UILabel playing;

	public UILabel chatLabel;

	public UILabel chatLabelTyping;

	public UILabel friendCountLabel;

	public UILabel friendLocationLabel;

	public UILabel friendNameLabel;

	public UILabel survivalScoreLabel;

	public UILabel winCountLabel;

	public UILabel totalWinCountLabel;

	public UILabel clanName;

	public UIInput editorInput;

	public UITexture clanLogo;

	private bool _escapePressed;

	private float lastTime;

	private float idleTimerLastTime;

	private TouchScreenKeyboard _keyboard;

	private IList<Rilisoft.Message> _messages = new List<Rilisoft.Message>();

	private State _state;

	private static readonly IDictionary<OnlineState, string> _onlineSprites = new Dictionary<OnlineState, string>
	{
		{
			OnlineState.Offline,
			"avatar_offline"
		},
		{
			OnlineState.Online,
			"avatar_online"
		},
		{
			OnlineState.Playing,
			"avatar_playing"
		}
	};

	public bool Compatible { get; set; }

	public string FriendLocation { get; set; }

	public int FriendCount { get; set; }

	public string FriendName { get; set; }

	public OnlineState Online { get; set; }

	public int Rank { get; set; }

	public int SurvivalScore { get; set; }

	public string Username { get; set; }

	public int WinCount { get; set; }

	public int TotalWinCount { get; set; }

	public event EventHandler BackPressed;

	public event EventHandler JoinPressed;

	public event EventHandler<MessageEventArgs> MessageCommitted;

	public event EventHandler UpdateRequested;

	public void Reset()
	{
		if (_keyboard != null)
		{
			_keyboard.active = false;
			_keyboard = null;
		}
		if (chatForeground != null)
		{
			chatForeground.gameObject.SetActive(false);
		}
		_state = State.Idle;
		Compatible = false;
		FriendLocation = string.Empty;
		FriendCount = 0;
		FriendName = string.Empty;
		Online = OnlineState.Offline;
		Rank = 0;
		SurvivalScore = 0;
		Username = string.Empty;
		WinCount = 0;
		_messages = new List<Rilisoft.Message>();
		if (chatLabel != null)
		{
			chatLabel.text = string.Empty;
		}
		if (chatLabelTyping != null)
		{
			chatLabelTyping.text = string.Empty;
		}
		if (characterModel != null)
		{
			Texture texture = Resources.Load<Texture>(ResPath.Combine(Defs.MultSkinsDirectoryName, "multi_skin_1"));
			if (texture != null)
			{
				GameObject[] stopObjs = new GameObject[6]
				{
					(bootsPoint == null || bootsPoint.Length <= 0) ? null : bootsPoint[0].transform.parent.gameObject,
					hatPoint,
					capePoint,
					armorPoint,
					armorLeftPl,
					armorRightPl
				};
				Player_move_c.SetTextureRecursivelyFrom(characterModel, texture, stopObjs);
			}
		}
		SetOnlineLabels(OnlineState.Offline);
		if (editorInput != null)
		{
			editorInput.gameObject.SetActive(Application.isEditor);
		}
		if (bootsPoint != null && bootsPoint.Length > 0)
		{
			GameObject[] array = bootsPoint;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(false);
			}
		}
		if (hatPoint != null)
		{
			Transform transform = hatPoint.transform;
			for (int j = 0; j != transform.childCount; j++)
			{
				Transform child = transform.GetChild(j);
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
		if (capePoint != null)
		{
			Transform transform2 = capePoint.transform;
			for (int k = 0; k != transform2.childCount; k++)
			{
				Transform child2 = transform2.GetChild(k);
				UnityEngine.Object.Destroy(child2.gameObject);
			}
		}
		if (armorPoint != null)
		{
			Transform transform3 = armorPoint.transform;
			for (int l = 0; l != transform3.childCount; l++)
			{
				Transform child3 = transform3.GetChild(l);
				UnityEngine.Object.Destroy(child3.gameObject);
			}
		}
	}

	public void SetMessages(IList<Rilisoft.Message> messages)
	{
		_messages = new List<Rilisoft.Message>(messages);
		UpdateMessages();
	}

	public void SetBoots(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			Debug.LogWarning("Name of boots should not be empty.");
		}
		else
		{
			if (bootsPoint == null || bootsPoint.Length <= 0)
			{
				return;
			}
			try
			{
				for (int i = 0; i != bootsPoint.Length; i++)
				{
					bootsPoint[i].SetActive(bootsPoint[i].name.Equals(name));
				}
			}
			catch (ArgumentException)
			{
			}
			catch (Exception)
			{
			}
		}
	}

	private void SetOnlineLabels(OnlineState onl)
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		switch (onl)
		{
		case OnlineState.Playing:
			flag3 = true;
			break;
		case OnlineState.Online:
			flag2 = true;
			break;
		default:
			flag = true;
			break;
		}
		offline.gameObject.SetActive(flag);
		onlineLab.gameObject.SetActive(flag2);
		playing.gameObject.SetActive(flag3);
	}

	public void SetStockCape(string capeName)
	{
		if (string.IsNullOrEmpty(capeName))
		{
			Debug.LogWarning("Name of cape should not be empty.");
		}
		else if (capePoint != null)
		{
			Transform transform = capePoint.transform;
			for (int i = 0; i != transform.childCount; i++)
			{
				Transform child = transform.GetChild(i);
				UnityEngine.Object.Destroy(child.gameObject);
			}
			UnityEngine.Object @object = Resources.Load("Capes/" + capeName);
			if (@object != null)
			{
				GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(@object);
				gameObject.transform.parent = transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				Player_move_c.SetLayerRecursively(gameObject, capePoint.layer);
			}
		}
	}

	public void SetCustomCape(byte[] capeBytes)
	{
		if (capePoint != null)
		{
			Transform transform = capePoint.transform;
			for (int i = 0; i != transform.childCount; i++)
			{
				Transform child = transform.GetChild(i);
				UnityEngine.Object.Destroy(child.gameObject);
			}
			UnityEngine.Object @object = Resources.Load("Capes/" + Wear.cape_Custom);
			if (@object != null)
			{
				capeBytes = capeBytes ?? new byte[0];
				Texture2D texture2D = new Texture2D(12, 16, TextureFormat.ARGB32, false);
				texture2D.LoadImage(capeBytes);
				texture2D.filterMode = FilterMode.Point;
				texture2D.Apply();
				GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(@object);
				gameObject.transform.parent = transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				Player_move_c.SetLayerRecursively(gameObject, capePoint.layer);
				gameObject.GetComponent<CustomCapePicker>().shouldLoadTexture = false;
				Player_move_c.SetTextureRecursivelyFrom(gameObject, texture2D, new GameObject[0]);
			}
		}
	}

	public void SetArmor(string armorName)
	{
		if (string.IsNullOrEmpty(armorName))
		{
			Debug.LogWarning("Name of armor should not be empty.");
			return;
		}
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < armorPoint.transform.childCount; i++)
		{
			list.Add(armorPoint.transform.GetChild(i));
		}
		foreach (Transform item in list)
		{
			ArmorRefs component = item.GetChild(0).GetComponent<ArmorRefs>();
			if (component != null)
			{
				if (component.leftBone != null)
				{
					component.leftBone.parent = item.GetChild(0);
				}
				if (component.rightBone != null)
				{
					component.rightBone.parent = item.GetChild(0);
				}
				item.parent = null;
				UnityEngine.Object.Destroy(item.gameObject);
			}
		}
		if (armorName.Equals(Defs.ArmorNewNoneEqupped))
		{
			return;
		}
		UnityEngine.Object @object = Resources.Load("Armor/" + armorName);
		if (!(@object == null))
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(@object) as GameObject;
			ArmorRefs component2 = gameObject.transform.GetChild(0).GetComponent<ArmorRefs>();
			if (component2 != null)
			{
				component2.leftBone.parent = armorLeftPl.transform;
				component2.leftBone.localPosition = Vector3.zero;
				component2.leftBone.localRotation = Quaternion.identity;
				component2.leftBone.localScale = new Vector3(1f, 1f, 1f);
				component2.rightBone.parent = armorRightPl.transform;
				component2.rightBone.localPosition = Vector3.zero;
				component2.rightBone.localRotation = Quaternion.identity;
				component2.rightBone.localScale = new Vector3(1f, 1f, 1f);
				gameObject.transform.parent = armorPoint.transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
				Player_move_c.SetLayerRecursively(gameObject, armorPoint.layer);
			}
		}
	}

	public void SetHat(string hatName)
	{
		if (string.IsNullOrEmpty(hatName))
		{
			Debug.LogWarning("Name of hat should not be empty.");
		}
		else if (hatPoint != null)
		{
			Transform transform = hatPoint.transform;
			for (int i = 0; i != transform.childCount; i++)
			{
				Transform child = transform.GetChild(i);
				UnityEngine.Object.Destroy(child.gameObject);
			}
			UnityEngine.Object @object = Resources.Load("Hats/" + hatName);
			if (@object != null)
			{
				GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(@object);
				gameObject.transform.parent = transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				Player_move_c.SetLayerRecursively(gameObject, hatPoint.layer);
			}
		}
	}

	public void SetSkin(byte[] skinBytes)
	{
		skinBytes = skinBytes ?? new byte[0];
		if (characterModel != null)
		{
			Func<byte[], Texture2D> func = delegate(byte[] bytes)
			{
				Texture2D texture2D = new Texture2D(64, 32)
				{
					filterMode = FilterMode.Point
				};
				texture2D.LoadImage(bytes);
				texture2D.Apply();
				return texture2D;
			};
			Texture2D txt = ((skinBytes.Length <= 0) ? Resources.Load<Texture2D>(ResPath.Combine(Defs.MultSkinsDirectoryName, "multi_skin_1")) : func(skinBytes));
			GameObject[] stopObjs = new GameObject[6]
			{
				(bootsPoint == null || bootsPoint.Length <= 0) ? null : bootsPoint[0].transform.parent.gameObject,
				hatPoint,
				capePoint,
				armorPoint,
				armorLeftPl,
				armorRightPl
			};
			Player_move_c.SetTextureRecursivelyFrom(characterModel, txt, stopObjs);
		}
	}

	private void Awake()
	{
		HOTween.Init(true, true, true);
		HOTween.EnableOverwriteManager(true);
		Reset();
		if (backButton != null)
		{
			ButtonHandler component = backButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += RaiseBackPressedEvent;
			}
		}
		if (joinButton != null)
		{
			ButtonHandler component2 = joinButton.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += RaiseJoinPressedEvent;
			}
		}
		if (messageButton != null)
		{
			ButtonHandler component3 = messageButton.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += HandleMessageButton;
			}
		}
	}

	private static string FormatMessages(string friendName, IList<Rilisoft.Message> messages)
	{
		if (friendName == null)
		{
			friendName = string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		StringComparer ordinal = StringComparer.Ordinal;
		List<Rilisoft.Message> list = new List<Rilisoft.Message>(messages);
		int num = list.Count - 10;
		if (num > 0)
		{
			list.RemoveRange(0, num);
		}
		foreach (Rilisoft.Message item in list)
		{
			string arg = item.Text.Replace('[', '{');
			string arg2 = ((item.SenderName.Length <= 15) ? item.SenderName : (item.SenderName.Substring(0, 14).TrimEnd() + "_"));
			string arg3 = ((ordinal.Compare(item.SenderName, friendName) != 0) ? "00FF00" : "FFFFFF");
			string value = string.Format("[{0}]<{1}> {2}[-]", arg3, arg2, arg);
			stringBuilder.AppendLine(value);
		}
		return stringBuilder.ToString();
	}

	private void HandleMessageButton(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			if (editorInput != null)
			{
				Rilisoft.Message message = new Rilisoft.Message();
				message.SenderName = Username;
				message.Text = editorInput.value;
				message.Timestamp = DateTimeOffset.UtcNow;
				Rilisoft.Message message2 = message;
				_messages.Add(message2);
				RaiseMessagePressedEvent(message2);
				UpdateMessages();
				editorInput.value = string.Empty;
			}
		}
		else
		{
			_state = State.Chatting;
			if (chatForeground != null)
			{
				chatForeground.gameObject.SetActive(true);
			}
			_keyboard = TouchScreenKeyboard.Open(string.Empty, TouchScreenKeyboardType.Default, false, false);
		}
	}

	private void OnDisable()
	{
		StopCoroutine("RequestUpdate");
	}

	private void OnEnable()
	{
		StartCoroutine("RequestUpdate");
		idleTimerLastTime = Time.realtimeSinceStartup;
	}

	private void RaiseBackPressedEvent(object sender, EventArgs e)
	{
		if (_state == State.Idle)
		{
			EventHandler backPressed = this.BackPressed;
			if (backPressed != null)
			{
				backPressed(sender, e);
			}
		}
	}

	private void RaiseJoinPressedEvent(object sender, EventArgs e)
	{
		if (_state == State.Idle)
		{
			EventHandler joinPressed = this.JoinPressed;
			if (joinPressed != null)
			{
				joinPressed(sender, e);
			}
		}
	}

	private void RaiseMessagePressedEvent(Rilisoft.Message message)
	{
		EventHandler<MessageEventArgs> messageCommitted = this.MessageCommitted;
		if (messageCommitted != null)
		{
			messageCommitted(this, new MessageEventArgs
			{
				Message = message
			});
		}
	}

	[Obfuscation(Exclude = true)]
	private IEnumerator RequestUpdate()
	{
		while (true)
		{
			EventHandler handler = this.UpdateRequested;
			if (handler != null)
			{
				handler(this, EventArgs.Empty);
			}
			yield return new WaitForSeconds(5f);
		}
	}

	private void Update()
	{
		if (_escapePressed)
		{
			_escapePressed = false;
			RaiseBackPressedEvent(this, EventArgs.Empty);
			return;
		}
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_escapePressed = true;
		}
		UpdateLightweight();
		float num = -120f;
		num *= ((BuildSettings.BuildTarget != BuildTarget.Android) ? 0.5f : 2f);
		Rect rect = new Rect(0f, 0.1f * (float)Screen.height, 0.5f * (float)Screen.width, 0.8f * (float)Screen.height);
		if (Input.touchCount > 0)
		{
			Touch touch = Input.GetTouch(0);
			if (touch.phase == TouchPhase.Moved && rect.Contains(touch.position))
			{
				idleTimerLastTime = Time.realtimeSinceStartup;
				pers.Rotate(Vector3.up, touch.deltaPosition.x * num * 0.5f * (Time.realtimeSinceStartup - lastTime));
			}
		}
		if (Application.isEditor)
		{
			float num2 = Input.GetAxis("Mouse ScrollWheel") * 3f * num * (Time.realtimeSinceStartup - lastTime);
			pers.Rotate(Vector3.up, num2);
			if (num2 != 0f)
			{
				idleTimerLastTime = Time.realtimeSinceStartup;
			}
		}
		if (Time.realtimeSinceStartup - idleTimerLastTime > ShopNGUIController.IdleTimeoutPers)
		{
			ReturnPersTonNormState();
		}
		lastTime = Time.realtimeSinceStartup;
	}

	private void ReturnPersTonNormState()
	{
		HOTween.Kill(pers);
		Vector3 p_endVal = new Vector3(0f, -180f, 0f);
		idleTimerLastTime = Time.realtimeSinceStartup;
		HOTween.To(pers, 0.5f, new TweenParms().Prop("localRotation", new PlugQuaternion(p_endVal)).Ease(EaseType.Linear).OnComplete((TweenDelegate.TweenCallback)delegate
		{
			idleTimerLastTime = Time.realtimeSinceStartup;
		}));
	}

	private void UpdateLightweight()
	{
		if (chatLabel != null && chatLabelTyping != null)
		{
			chatLabelTyping.text = chatLabel.text;
		}
		if (friendLocationLabel != null)
		{
			friendLocationLabel.text = FriendLocation ?? string.Empty;
		}
		if (friendCountLabel != null)
		{
			friendCountLabel.text = ((FriendCount >= 0) ? FriendCount.ToString() : "-");
		}
		if (friendNameLabel != null)
		{
			friendNameLabel.text = FriendName ?? string.Empty;
		}
		OnlineState onlineLabels = Online;
		if (Online == OnlineState.Playing && !Compatible)
		{
			onlineLabels = OnlineState.Online;
		}
		SetOnlineLabels(onlineLabels);
		if (joinButton != null)
		{
			joinButton.isEnabled = Compatible && Online == OnlineState.Playing;
		}
		if (messageButton != null)
		{
			bool flag = false;
			messageButton.gameObject.SetActive(flag);
		}
		if (rankSprite != null)
		{
			string text = "Rank_" + Rank;
			if (!rankSprite.spriteName.Equals(text))
			{
				rankSprite.spriteName = text;
			}
		}
		if (survivalScoreLabel != null)
		{
			survivalScoreLabel.text = SurvivalScore.ToString();
		}
		if (winCountLabel != null)
		{
			winCountLabel.text = WinCount.ToString();
		}
		if (totalWinCountLabel != null)
		{
			totalWinCountLabel.text = TotalWinCount.ToString();
		}
		State state = _state;
		if (state != State.Chatting || _keyboard == null)
		{
			return;
		}
		if (!string.IsNullOrEmpty(_keyboard.text) && _keyboard.text.Length > 40)
		{
			_keyboard.text = _keyboard.text.Substring(0, 40);
		}
		bool done = _keyboard.done;
		if (done && !string.IsNullOrEmpty(_keyboard.text))
		{
			string text2 = _keyboard.text;
			Rilisoft.Message message = new Rilisoft.Message();
			message.Text = text2;
			message.Timestamp = DateTimeOffset.UtcNow;
			message.SenderName = Username;
			Rilisoft.Message message2 = message;
			_messages.Add(message2);
			RaiseMessagePressedEvent(message2);
			UpdateMessages();
		}
		if (_keyboard.wasCanceled || done)
		{
			if (chatForeground != null)
			{
				chatForeground.gameObject.SetActive(false);
			}
			_keyboard.active = false;
			_keyboard = null;
			_state = State.Idle;
		}
	}

	private void UpdateMessages()
	{
		if (chatLabel != null)
		{
			chatLabel.text = FormatMessages(FriendName, _messages);
		}
	}
}
