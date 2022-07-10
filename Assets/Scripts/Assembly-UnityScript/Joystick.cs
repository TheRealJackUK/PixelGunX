using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
public class Joystick : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024BlinkReload_002448 : GenericGenerator<WaitForSeconds>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<WaitForSeconds>, IEnumerator
		{
			internal Joystick _0024self__002449;

			public _0024(Joystick self_)
			{
				_0024self__002449 = self_;
			}

			public override bool MoveNext()
			{
				//Discarded unreachable code: IL_0050
				int result;
				switch (_state)
				{
				default:
					result = (Yield(2, new WaitForSeconds(0.5f)) ? 1 : 0);
					break;
				case 2:
					_0024self__002449.blink = !_0024self__002449.blink;
					goto default;
				case 1:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		internal Joystick _0024self__002450;

		public _0024BlinkReload_002448(Joystick self_)
		{
			_0024self__002450 = self_;
		}

		public override IEnumerator<WaitForSeconds> GetEnumerator()
		{
			return new _0024(_0024self__002450);
		}
	}

	[NonSerialized]
	private static Joystick[] joysticks;

	[NonSerialized]
	private static bool enumeratedJoysticks;

	[NonSerialized]
	private static float tapTimeDelta = 0.3f;

	public bool touchPad;

	public Rect touchZone;

	public Vector2 deadZone;

	public bool normalize;

	public Vector2 position;

	public int tapCount;

	public bool halfScreenZone;

	private int lastFingerId;

	private float tapTimeWindow;

	public Vector2 fingerDownPos;

	private float fingerDownTime;

	private float firstDeltaTime;

	private Rect defaultRect;

	private Boundary guiBoundary;

	private Vector2 guiTouchOffset;

	private Vector2 guiCenter;

	public bool jumpPressed;

	public Texture fireTexture;

	public Texture reloadTexture;

	public Texture reloadTextureNoAmmo;

	private Rect fireZone;

	public GameObject _playerGun;

	private Rect reloadZone;

	private Rect joystickZone;

	private Vector2 _lastFingerPosition;

	private bool blink;

	private bool NormalReloadMode;

	private bool isSerialShooting;

	public Vector3 pos;

	private Rect guiPixelInset;

	private Rect jumpTexturePixelInset;

	private Texture2D gui;

	private Texture2D jumpTexture;

	private float guiCoeff;

	private bool touchBeginsOnFireZone;

	public Joystick()
	{
		deadZone = Vector2.zero;
		lastFingerId = -1;
		firstDeltaTime = 0.5f;
		guiBoundary = new Boundary();
		NormalReloadMode = true;
		pos = new Vector3(0f, 0f, 0f);
		guiCoeff = (float)Screen.height / 640f;
	}

	public virtual void NoAmmo()
	{
		if (NormalReloadMode)
		{
			NormalReloadMode = false;
			StartCoroutine("BlinkReload");
		}
	}

	public virtual void HasAmmo()
	{
		if (!NormalReloadMode)
		{
			NormalReloadMode = true;
			StopCoroutine("BlinkReload");
			blink = false;
		}
	}

	public virtual IEnumerator BlinkReload()
	{
		return new _0024BlinkReload_002448(this).GetEnumerator();
	}

	public virtual void Awake()
	{
	}

	public virtual void Start()
	{
		if (!touchPad)
		{
			guiPixelInset = new Rect(0f, 0f, 128f, 128f);
			gui = (Texture2D)(Resources.Load("Move") as Texture);
		}
		else
		{
			guiPixelInset = new Rect(-200f, 0f, 200f, 125f);
			gui = (Texture2D)(Resources.Load("Jump") as Texture);
		}
		if (touchPad)
		{
			int num = 1;
			Vector3 vector = transform.position;
			float num2 = (vector.x = num);
			Vector3 vector3 = (transform.position = vector);
		}
		guiPixelInset = new Rect(guiPixelInset.x * (float)Screen.height / 640f, guiPixelInset.y * (float)Screen.height / 640f, guiPixelInset.width * (float)Screen.height / 640f, guiPixelInset.height * (float)Screen.height / 640f);
		defaultRect = guiPixelInset;
		defaultRect.x += pos.x * (float)Screen.width;
		defaultRect.y += pos.y * (float)Screen.height;
		float num3 = 1.2f;
		if (halfScreenZone)
		{
			defaultRect.y = 0f;
			defaultRect.x = (float)Screen.width / 2f;
			defaultRect.width = (float)Screen.width / 2f;
			defaultRect.height = (float)Screen.height * 0.6f;
			jumpTexture = gui;
			float num4 = (num3 - 1f) * 0.5f;
			jumpTexture = gui;
			jumpTexturePixelInset = new Rect((float)Screen.width - (float)jumpTexture.width * (num4 + 1f) * (float)Screen.height / 640f, (float)(jumpTexture.height * Screen.height / 640) * num4 / 2f, jumpTexture.width * Screen.height / 640, jumpTexture.height * Screen.height / 640);
			guiPixelInset = jumpTexturePixelInset;
			int num5 = fireTexture.width * Screen.height / 640;
			fireZone = new Rect((float)Screen.width - (float)Screen.height * 0.4f, (float)Screen.height * 0.15f - (float)(num5 / 2), num5, num5);
			if ((bool)reloadTexture)
			{
				reloadZone = new Rect((float)Screen.width - (float)reloadTexture.width * 1.1f * (float)Screen.height / 640f, (float)Screen.height * 0.4f, fireZone.width * 0.65f, fireZone.height * 0.65f);
			}
		}
		else if ((bool)reloadTexture)
		{
			reloadZone = new Rect((float)Screen.width - (float)reloadTexture.width * 1.1f * (float)Screen.height / 640f, (float)Screen.height * 0.4f, fireZone.width * 0.65f, fireZone.height * 0.65f);
		}
		pos.x = 0f;
		pos.y = 0f;
		if (touchPad)
		{
			touchZone = defaultRect;
			return;
		}
		joystickZone = new Rect(0f, 0f, (float)Screen.width / 2f, (float)Screen.height / 2f);
		defaultRect = guiPixelInset;
		defaultRect.x = (float)Screen.height * 0.1f;
		defaultRect.y = (float)Screen.height * 0.1f;
		guiTouchOffset.x = defaultRect.width * 0.5f;
		guiTouchOffset.y = defaultRect.height * 0.5f;
		guiCenter.x = defaultRect.x + guiTouchOffset.x;
		guiCenter.y = defaultRect.y + guiTouchOffset.y;
		guiBoundary.min.x = defaultRect.x - guiTouchOffset.x;
		guiBoundary.max.x = defaultRect.x + guiTouchOffset.x;
		guiBoundary.min.y = defaultRect.y - guiTouchOffset.y;
		guiBoundary.max.y = defaultRect.y + guiTouchOffset.y;
	}

	public virtual void Disable()
	{
		gameObject.active = false;
		enumeratedJoysticks = false;
	}

	public virtual void Enable()
	{
		gameObject.active = true;
	}

	public virtual void ResetJoystick()
	{
		if ((!halfScreenZone || !touchPad || !touchPad) && (bool)gui)
		{
			guiPixelInset = defaultRect;
		}
		lastFingerId = -1;
		position = Vector2.zero;
		fingerDownPos = Vector2.zero;
	}

	public virtual bool IsFingerDown()
	{
		return lastFingerId != -1;
	}

	public virtual void LatchedFinger(int fingerId)
	{
		if (lastFingerId == fingerId)
		{
			ResetJoystick();
		}
	}

	public virtual void Update()
	{
		if (!enumeratedJoysticks)
		{
			joysticks = ((Joystick[])UnityEngine.Object.FindObjectsOfType(typeof(Joystick))) as Joystick[];
			enumeratedJoysticks = true;
		}
		int touchCount = Input.touchCount;
		if (!(tapTimeWindow <= 0f))
		{
			tapTimeWindow -= Time.deltaTime;
		}
		else
		{
			tapCount = 0;
		}
		if (touchCount == 0)
		{
			ResetJoystick();
		}
		else
		{
			for (int i = 0; i < touchCount; i++)
			{
				Touch touch = Input.GetTouch(i);
				Vector2 vector = touch.position - guiTouchOffset;
				bool flag = false;
				if (touchPad)
				{
					if (touchZone.Contains(touch.position))
					{
						flag = true;
					}
				}
				else if (guiPixelInset.Contains(touch.position))
				{
					flag = true;
				}
				isSerialShooting = PlayerPrefs.GetInt("setSeriya") == 1;
				bool num = flag;
				if (num)
				{
					num = lastFingerId == -1;
					if (!num)
					{
						num = lastFingerId != touch.fingerId;
					}
				}
				bool flag2 = num;
				if (flag2)
				{
					touchBeginsOnFireZone = fireZone.Contains(touch.position);
				}
				if (isSerialShooting && touchPad && flag)
				{
					if ((bool)fireTexture && touchZone.Contains(touch.position) && touchBeginsOnFireZone && !blink)
					{
						_playerGun.SendMessage("ShotPressed");
					}
					else
					{
						touchBeginsOnFireZone = false;
					}
				}
				if (flag2)
				{
					if (touchPad)
					{
						lastFingerId = touch.fingerId;
						fingerDownPos = touch.position;
						fingerDownTime = Time.time;
					}
					lastFingerId = touch.fingerId;
					if (!(tapTimeWindow <= 0f))
					{
						tapCount++;
					}
					else
					{
						tapCount = 1;
						tapTimeWindow = tapTimeDelta;
					}
					int j = 0;
					Joystick[] array = joysticks;
					for (int length = array.Length; j < length; j++)
					{
						if (array[j] != this)
						{
							array[j].LatchedFinger(touch.fingerId);
						}
					}
					if ((bool)fireTexture && fireZone.Contains(touch.position) && !isSerialShooting)
					{
						_playerGun.SendMessage("ShotPressed");
						continue;
					}
					if ((bool)jumpTexture && jumpTexturePixelInset.Contains(touch.position))
					{
						jumpPressed = true;
					}
					if (touchPad && reloadZone.Contains(touch.position))
					{
						_playerGun.SendMessage("ReloadPressed");
					}
					if (touchPad)
					{
						_lastFingerPosition = touch.position;
					}
				}
				if (lastFingerId == touch.fingerId)
				{
					if (touch.tapCount > tapCount)
					{
						tapCount = touch.tapCount;
					}
					if (touchPad)
					{
						float num2 = 25f;
						position.x = Mathf.Clamp((touch.position.x - fingerDownPos.x) * 1f / 1f, 0f - num2, num2);
						position.y = Mathf.Clamp((touch.position.y - fingerDownPos.y) * 1f / 1f, 0f - num2, num2);
						fingerDownPos = touch.position;
					}
					else
					{
						guiPixelInset.x = Mathf.Clamp(vector.x, guiBoundary.min.x, guiBoundary.max.x);
						guiPixelInset.y = Mathf.Clamp(vector.y, guiBoundary.min.y, guiBoundary.max.y);
					}
					if (!flag2 && touchPad && touchZone.Contains(touch.position))
					{
						_lastFingerPosition = touch.position;
					}
					if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled)
					{
						ResetJoystick();
					}
				}
			}
		}
		if (!touchPad)
		{
			position.x = (guiPixelInset.x + guiTouchOffset.x - guiCenter.x) / guiTouchOffset.x;
			position.y = (guiPixelInset.y + guiTouchOffset.y - guiCenter.y) / guiTouchOffset.y;
		}
		float num3 = Mathf.Abs(position.x);
		float num4 = Mathf.Abs(position.y);
		if (!(num3 >= deadZone.x))
		{
			position.x = 0f;
		}
		else if (normalize)
		{
			position.x = Mathf.Sign(position.x) * (num3 - deadZone.x) / (1f - deadZone.x);
		}
		if (!(num4 >= deadZone.y))
		{
			position.y = 0f;
		}
		else if (normalize)
		{
			position.y = Mathf.Sign(position.y) * (num4 - deadZone.y) / (1f - deadZone.y);
		}
	}

	public virtual void OnGUI()
	{
		Color color = GUI.color;
		GUI.color = new Color(color.r, color.g, color.b, 38f);
		if ((bool)fireTexture)
		{
			GUI.DrawTexture(new Rect(fireZone.x, (float)Screen.height - fireZone.height - fireZone.y, fireZone.width, fireZone.height), fireTexture);
		}
		if ((bool)reloadTexture)
		{
			GUI.DrawTexture(new Rect(reloadZone.x, (float)Screen.height - reloadZone.height - reloadZone.y, reloadZone.height, reloadZone.height), NormalReloadMode ? reloadTexture : ((!blink) ? reloadTexture : reloadTextureNoAmmo));
		}
		if ((bool)gui)
		{
			GUI.DrawTexture(new Rect(guiPixelInset.x, (float)Screen.height - guiPixelInset.height - guiPixelInset.y, guiPixelInset.width, guiPixelInset.height), gui);
		}
		GUI.color = color;
	}

	public virtual void setSeriya(bool isSeriya)
	{
		isSerialShooting = isSeriya;
	}

	public virtual void Main()
	{
	}
}
