using UnityEngine;

public class UISlider : UIProgressBar
{
	private enum Direction
	{
		Horizontal = 0,
		Vertical = 1,
		Upgraded = 2,
	}

	[SerializeField]
	private Transform transform_2;
	[SerializeField]
	private float float_2;
	[SerializeField]
	private Direction direction_0;
	[SerializeField]
	protected bool bool_1;
}
