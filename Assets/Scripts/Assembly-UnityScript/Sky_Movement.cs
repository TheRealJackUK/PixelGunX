using System;
using UnityEngine;

[Serializable]
public class Sky_Movement : MonoBehaviour
{
	public float speed;

	public float alpha;

	public float waveScale;

	public Sky_Movement()
	{
		speed = 0.7f;
		alpha = 1f;
		waveScale = 1f;
	}

	public virtual void Update()
	{
		float time = Time.time;
		float x = Mathf.Repeat(time * speed, 100f) * 0.15f;
		gameObject.GetComponent<Renderer>().material.mainTextureOffset = new Vector2(x, 0f);
		float a = alpha;
		Color color = gameObject.GetComponent<Renderer>().material.color;
		float num = (color.a = a);
		Color color3 = (gameObject.GetComponent<Renderer>().material.color = color);
		gameObject.GetComponent<Renderer>().material.mainTextureScale = new Vector2(waveScale, waveScale);
	}

	public virtual void Main()
	{
	}
}
