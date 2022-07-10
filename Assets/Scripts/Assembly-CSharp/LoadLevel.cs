using UnityEngine;

public class LoadLevel : MonoBehaviour
{
	public Texture fon;

	private void Start()
	{
		Application.LoadLevel("Level3");
	}

	private void OnGUI()
	{
		Rect position = new Rect(((float)Screen.width - 1366f * Defs.Coef) / 2f, 0f, 1366f * Defs.Coef, Screen.height);
		GUI.DrawTexture(position, fon, ScaleMode.StretchToFill);
	}
}
