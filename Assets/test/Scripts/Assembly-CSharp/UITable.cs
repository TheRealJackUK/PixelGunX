using UnityEngine;

public class UITable : UIWidgetContainer
{
	public enum Direction
	{
		Down = 0,
		Up = 1,
	}

	public enum Sorting
	{
		None = 0,
		Alphabetic = 1,
		Horizontal = 2,
		Vertical = 3,
		Custom = 4,
	}

	public int int_0;
	public Direction direction_0;
	public Sorting sorting_0;
	public bool bool_0;
	public bool bool_1;
	public Vector2 vector2_0;
	[SerializeField]
	private bool bool_4;
}
