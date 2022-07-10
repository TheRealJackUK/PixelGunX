using System;
using UnityEngine;

[Serializable]
public class WaterMovement : MonoBehaviour
{
	public float speed;

	public float alpha;

	public float waveScale;

	public WaterMovement()
	{
		speed = 0.7f;
		alpha = 0.5f;
		waveScale = 3f;
	}

	public virtual void Update()
	{
		float time = Time.time;
		float num = Mathf.PingPong(time * speed, 100f) * 0.15f;
		gameObject.GetComponent<Renderer>().material.mainTextureOffset = new Vector2(num, num);
		float a = alpha;
		Color color = gameObject.GetComponent<Renderer>().material.color;
		float num2 = (color.a = a);
		Color color3 = (gameObject.GetComponent<Renderer>().material.color = color);
		gameObject.GetComponent<Renderer>().material.mainTextureScale = new Vector2(waveScale, waveScale);
	}

	public virtual void Main()
	{
	}
}
