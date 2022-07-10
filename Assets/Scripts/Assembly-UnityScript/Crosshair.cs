using System;
using UnityEngine;

[Serializable]
public class Crosshair : MonoBehaviour
{
	public Texture2D crosshairTexture;

	public Rect position;

	public virtual void Start()
	{
		position = new Rect((Screen.width - crosshairTexture.width * Screen.height / 640) / 2, (Screen.height - crosshairTexture.height * Screen.height / 640) / 2, crosshairTexture.width * Screen.height / 640, crosshairTexture.height * Screen.height / 640);
	}

	public virtual void OnGUI()
	{
		GUI.DrawTexture(position, crosshairTexture);
	}

	public virtual void Main()
	{
	}
}
