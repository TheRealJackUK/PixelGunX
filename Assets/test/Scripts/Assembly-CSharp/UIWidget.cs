using UnityEngine;

public class UIWidget : UIRect
{
	public enum Pivot
	{
		TopLeft = 0,
		Top = 1,
		TopRight = 2,
		Left = 3,
		Center = 4,
		Right = 5,
		BottomLeft = 6,
		Bottom = 7,
		BottomRight = 8,
	}

	public enum AspectRatioSource
	{
		Free = 0,
		BasedOnWidth = 1,
		BasedOnHeight = 2,
	}

	[SerializeField]
	protected Color color_0;
	[SerializeField]
	protected Pivot pivot_0;
	[SerializeField]
	protected int int_1;
	[SerializeField]
	protected int int_2;
	[SerializeField]
	protected int int_3;
	public bool bool_6;
	public bool bool_7;
	public AspectRatioSource aspectRatioSource_0;
	public float float_0;
}
