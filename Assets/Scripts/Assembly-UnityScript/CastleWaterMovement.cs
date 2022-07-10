using System;
using UnityEngine;

[Serializable]
public class CastleWaterMovement : MonoBehaviour
{
	public float speed;

	public float alpha;

	public float waveScale;

	public CastleWaterMovement()
	{
		speed = 0.7f;
		alpha = 0.5f;
		waveScale = 3f;
	}

	public virtual void Update()
	{
		float time = Time.time;
		float y = Mathf.Repeat(time * speed, 100f) * 0.15f;
		gameObject.GetComponent<Renderer>().material.mainTextureOffset = new Vector2(0f, y);
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
