using UnityEngine;

public class UIGrid : UIWidgetContainer
{
	public enum Arrangement
	{
		Horizontal = 0,
		Vertical = 1,
	}

	public enum Sorting
	{
		None = 0,
		Alphabetic = 1,
		Horizontal = 2,
		Vertical = 3,
		Custom = 4,
	}

	public Arrangement arrangement_0;
	public Sorting sorting_0;
	public UIWidget.Pivot pivot_0;
	public int int_0;
	public float float_0;
	public float float_1;
	public bool bool_0;
	public bool bool_1;
	public bool bool_2;
	[SerializeField]
	private bool bool_3;
}
