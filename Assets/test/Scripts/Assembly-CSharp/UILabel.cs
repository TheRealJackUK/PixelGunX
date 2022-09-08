using UnityEngine;

public class UILabel : UIWidget
{
	public enum Crispness
	{
		Never = 0,
		OnDesktop = 1,
		Always = 2,
	}

	public enum Effect
	{
		None = 0,
		Shadow = 1,
		Outline = 2,
	}

	public enum Overflow
	{
		ShrinkContent = 0,
		ClampContent = 1,
		ResizeFreely = 2,
		ResizeHeight = 3,
	}

	public Crispness crispness_0;
	[SerializeField]
	private Font font_0;
	[SerializeField]
	private UIFont uifont_0;
	[SerializeField]
	[MultilineAttribute]
	private string string_0;
	[SerializeField]
	private int int_6;
	[SerializeField]
	private FontStyle fontStyle_0;
	[SerializeField]
	private NGUIText.Alignment alignment_0;
	[SerializeField]
	private bool bool_14;
	[SerializeField]
	private int int_7;
	[SerializeField]
	private Effect effect_0;
	[SerializeField]
	private Color color_1;
	[SerializeField]
	private NGUIText.SymbolStyle symbolStyle_0;
	[SerializeField]
	private Vector2 vector2_0;
	[SerializeField]
	private Overflow overflow_0;
	[SerializeField]
	private Material material_0;
	[SerializeField]
	private bool bool_15;
	[SerializeField]
	private Color color_2;
	[SerializeField]
	private Color color_3;
	[SerializeField]
	private int int_8;
	[SerializeField]
	private int int_9;
	[SerializeField]
	private bool bool_16;
	[SerializeField]
	private int int_10;
	[SerializeField]
	private int int_11;
	[SerializeField]
	private float float_2;
	[SerializeField]
	private bool bool_17;
}
