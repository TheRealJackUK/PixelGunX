using UnityEngine;

public class UIBasicSprite : UIWidget
{
	public enum Type
	{
		Simple = 0,
		Sliced = 1,
		Tiled = 2,
		Filled = 3,
		Advanced = 4,
	}

	public enum FillDirection
	{
		Horizontal = 0,
		Vertical = 1,
		Radial90 = 2,
		Radial180 = 3,
		Radial360 = 4,
	}

	public enum Flip
	{
		Nothing = 0,
		Horizontally = 1,
		Vertically = 2,
		Both = 3,
	}

	public enum AdvancedType
	{
		Invisible = 0,
		Sliced = 1,
		Tiled = 2,
	}

	[SerializeField]
	protected Type type_0;
	[SerializeField]
	protected FillDirection fillDirection_0;
	[SerializeField]
	protected float float_2;
	[SerializeField]
	protected bool bool_14;
	[SerializeField]
	protected Flip flip_0;
	public AdvancedType advancedType_0;
	public AdvancedType advancedType_1;
	public AdvancedType advancedType_2;
	public AdvancedType advancedType_3;
	public AdvancedType advancedType_4;
}
