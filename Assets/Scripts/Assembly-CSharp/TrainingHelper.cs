using UnityEngine;

internal sealed class TrainingHelper : MonoBehaviour
{
	private Rect _buttonRect;

	private void Start()
	{
		float num = 211f * Defs.Coef;
		float num2 = 114f * Defs.Coef;
		float num3 = 12f * Defs.Coef;
		_buttonRect = new Rect((float)Screen.width - num - num3, num2 + 64f * Defs.Coef + 3f * num3, num, num2);
	}
}
