using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[AddComponentMenu("NGUI/UI/Root")]
[ExecuteInEditMode]
public class UIRoot : MonoBehaviour
{
	public enum Scaling
	{
		Flexible,
		Constrained,
		ConstrainedOnMobiles
	}

	public enum Constraint
	{
		Fit,
		Fill,
		FitWidth,
		FitHeight
	}

	public static List<UIRoot> list = new List<UIRoot>();

	public Scaling scalingStyle;

	public int manualWidth = 1280;

	public int manualHeight = 720;

	public int minimumHeight = 320;

	public int maximumHeight = 1536;

	public bool fitWidth;

	public bool fitHeight = true;

	public bool adjustByDPI;

	public bool shrinkPortraitUI;

	private Transform mTrans;

	public Constraint constraint
	{
		get
		{
			if (fitWidth)
			{
				if (fitHeight)
				{
					return Constraint.Fit;
				}
				return Constraint.FitWidth;
			}
			if (fitHeight)
			{
				return Constraint.FitHeight;
			}
			return Constraint.Fill;
		}
	}

	public Scaling activeScaling
	{
		get
		{
			Scaling scaling = scalingStyle;
			if (scaling == Scaling.ConstrainedOnMobiles)
			{
				return Scaling.Constrained;
			}
			return scaling;
		}
	}

	public int activeHeight
	{
		get
		{
			if (activeScaling == Scaling.Flexible)
			{
				Vector2 screenSize = NGUITools.screenSize;
				float num = screenSize.x / screenSize.y;
				if (screenSize.y < (float)minimumHeight)
				{
					screenSize.y = minimumHeight;
					screenSize.x = screenSize.y * num;
				}
				else if (screenSize.y > (float)maximumHeight)
				{
					screenSize.y = maximumHeight;
					screenSize.x = screenSize.y * num;
				}
				int num2 = Mathf.RoundToInt((!shrinkPortraitUI || !(screenSize.y > screenSize.x)) ? screenSize.y : (screenSize.y / num));
				return (!adjustByDPI) ? num2 : NGUIMath.AdjustByDPI(num2);
			}
			Constraint constraint = this.constraint;
			if (constraint == Constraint.FitHeight)
			{
				return manualHeight;
			}
			Vector2 screenSize2 = NGUITools.screenSize;
			float num3 = screenSize2.x / screenSize2.y;
			float num4 = (float)manualWidth / (float)manualHeight;
			switch (constraint)
			{
			case Constraint.FitWidth:
				return Mathf.RoundToInt((float)manualWidth / num3);
			case Constraint.Fit:
				return (!(num4 > num3)) ? manualHeight : Mathf.RoundToInt((float)manualWidth / num3);
			case Constraint.Fill:
				return (!(num4 < num3)) ? manualHeight : Mathf.RoundToInt((float)manualWidth / num3);
			default:
				return manualHeight;
			}
		}
	}

	public float pixelSizeAdjustment
	{
		get
		{
			int num = Mathf.RoundToInt(NGUITools.screenSize.y);
			return (num != -1) ? GetPixelSizeAdjustment(num) : 1f;
		}
	}

	public static float GetPixelSizeAdjustment(GameObject go)
	{
		UIRoot uIRoot = NGUITools.FindInParents<UIRoot>(go);
		return (!(uIRoot != null)) ? 1f : uIRoot.pixelSizeAdjustment;
	}

	public float GetPixelSizeAdjustment(int height)
	{
		height = Mathf.Max(2, height);
		if (activeScaling == Scaling.Constrained)
		{
			return (float)activeHeight / (float)height;
		}
		if (height < minimumHeight)
		{
			return (float)minimumHeight / (float)height;
		}
		if (height > maximumHeight)
		{
			return (float)maximumHeight / (float)height;
		}
		return 1f;
	}

	protected virtual void Awake()
	{
		if (Storager.getInt("camerafov", false) == 0 || Storager.getInt("camerafov", false) == null || Storager.getInt("camerafov", false) == 180)
		{
			Storager.setInt("camerafov", 44, false);
		}
		Storager.setInt(Defs.ShownLobbyLevelSN, 31, false);
		PhotonNetwork.PhotonServerSettings.UseCloud("60ccfc7e-5ab0-4fbb-82bd-650124a63b74", 0);
		mTrans = base.transform;
	}

	protected virtual void OnEnable()
	{
		list.Add(this);
	}

	protected virtual void OnDisable()
	{
		list.Remove(this);
	}

	protected virtual void Start()
	{
		UIOrthoCamera componentInChildren = GetComponentInChildren<UIOrthoCamera>();
		if (componentInChildren != null)
		{
			Debug.LogWarning("UIRoot should not be active at the same time as UIOrthoCamera. Disabling UIOrthoCamera.", componentInChildren);
			Camera component = componentInChildren.gameObject.GetComponent<Camera>();
			componentInChildren.enabled = false;
			if (component != null)
			{
				component.orthographicSize = 1f;
			}
		}
		else
		{
			Update();
		}
	}

	public string input11 = string.Empty;

	public void OnGUI()
	{
		if (Application.loadedLevelName == "DeveloperConsole") {
			input11 = GUI.TextField(new Rect(10, 120, 100, 20), input11, 25);
			if (GUI.Button(new Rect(10, 140, 80, 20), "load scene")) {
				Application.LoadLevel(input11);
			}
		}

	}

	private void Update()
	{
		if (Application.loadedLevelName.StartsWith("Menu_"))
		{
			if (GameObject.Find("Pers_Main_Point").GetComponent<PostProcessLayer>() == true && Application.isMobilePlatform)
			GameObject.Find("Pers_Main_Point").GetComponent<PostProcessVolume>().enabled = false;
		}
		
		if (!(mTrans != null))
		{
			return;
		}
		float num = activeHeight;
		if (num > 0f)
		{
			float num2 = 2f / num;
			Vector3 localScale = mTrans.localScale;
			if (!(Mathf.Abs(localScale.x - num2) <= float.Epsilon) || !(Mathf.Abs(localScale.y - num2) <= float.Epsilon) || !(Mathf.Abs(localScale.z - num2) <= float.Epsilon))
			{
				mTrans.localScale = new Vector3(num2, num2, num2);
			}
		}
	}

	public static void Broadcast(string funcName)
	{
		int i = 0;
		for (int count = list.Count; i < count; i++)
		{
			UIRoot uIRoot = list[i];
			if (uIRoot != null)
			{
				uIRoot.BroadcastMessage(funcName, SendMessageOptions.DontRequireReceiver);
			}
		}
	}

	public static void Broadcast(string funcName, object param)
	{
		if (param == null)
		{
			Debug.LogError("SendMessage is bugged when you try to pass 'null' in the parameter field. It behaves as if no parameter was specified.");
			return;
		}
		int i = 0;
		for (int count = list.Count; i < count; i++)
		{
			UIRoot uIRoot = list[i];
			if (uIRoot != null)
			{
				uIRoot.BroadcastMessage(funcName, param, SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
