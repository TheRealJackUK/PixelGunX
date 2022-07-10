using UnityEngine;

internal sealed class ControlSize : MonoBehaviour
{
	public int minValue;

	public int maxValue;

	public int defaultValue;

	private void Update()
	{
		if (maxValue < minValue)
		{
			maxValue = minValue;
		}
		if (defaultValue < minValue)
		{
			defaultValue = minValue;
		}
		if (defaultValue > maxValue)
		{
			defaultValue = maxValue;
		}
	}
}
