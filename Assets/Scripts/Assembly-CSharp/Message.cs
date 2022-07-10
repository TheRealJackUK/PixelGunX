using UnityEngine;

public sealed class Message : MonoBehaviour
{
	public GUIStyle labelStyle;

	public Rect rect = Player_move_c.SuccessMessageRect();

	public string message = "Purchases restored";

	public int depth = -2;

	private float _startTime;

	public float OnScreenTime = 3f;

	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		_startTime = Time.realtimeSinceStartup;
	}

	private void Remove()
	{
		Object.Destroy(base.gameObject);
	}

	private void OnGUI()
	{
		if (Time.realtimeSinceStartup - _startTime >= ((!Defs.IsTraining) ? OnScreenTime : (OnScreenTime / 2f)))
		{
			Remove();
			return;
		}
		rect = Player_move_c.SuccessMessageRect();
		GUI.depth = depth;
		labelStyle.fontSize = Player_move_c.FontSizeForMessages;
		GUI.Label(rect, message, labelStyle);
	}
}
