using UnityEngine;
using System;
using System.Collections.Generic;

public class UIAtlas : MonoBehaviour
{
	[Serializable]
	private class Sprite
	{
		public string name;
		public Rect outer;
		public Rect inner;
		public bool rotated;
		public float paddingLeft;
		public float paddingRight;
		public float paddingTop;
		public float paddingBottom;
	}

	private enum Coordinates
	{
		Pixels = 0,
		TexCoords = 1,
	}

	[SerializeField]
	private Material material_0;
	[SerializeField]
	private List<UISpriteData> list_0;
	[SerializeField]
	private float float_0;
	[SerializeField]
	private UIAtlas uiatlas_0;
	[SerializeField]
	private Coordinates coordinates_0;
	[SerializeField]
	private List<UIAtlas.Sprite> list_1;
}
