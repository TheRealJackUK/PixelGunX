using UnityEngine;

public class UIPanel : UIRect
{
	public enum RenderQueue
	{
		Automatic = 0,
		StartAt = 1,
		Explicit = 2,
	}

	public bool bool_6;
	public bool bool_7;
	public bool bool_8;
	public bool bool_9;
	public bool bool_10;
	public bool bool_11;
	public RenderQueue renderQueue_0;
	public int int_1;
	[SerializeField]
	private float float_0;
	[SerializeField]
	private UIDrawCall.Clipping clipping_0;
	[SerializeField]
	private Vector4 vector4_1;
	[SerializeField]
	private Vector2 vector2_0;
	[SerializeField]
	private int int_2;
	[SerializeField]
	private int int_3;
	[SerializeField]
	private Vector2 vector2_1;
}
