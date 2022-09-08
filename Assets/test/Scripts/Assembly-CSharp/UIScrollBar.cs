using UnityEngine;

public class UIScrollBar : UISlider
{
	private enum Direction
	{
		Horizontal = 0,
		Vertical = 1,
		Upgraded = 2,
	}

	[SerializeField]
	protected float float_3;
	[SerializeField]
	private float float_4;
	[SerializeField]
	private Direction direction_1;
}
