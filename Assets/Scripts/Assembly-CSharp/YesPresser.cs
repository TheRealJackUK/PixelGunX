using UnityEngine;

public sealed class YesPresser : SkipTrainingButton
{
	public GameObject noButton;

	private bool _clicked;

	protected override void OnClick()
	{
		if (!_clicked)
		{
			noButton.GetComponent<UIButton>().enabled = false;
			base.enabled = false;
			GotToNextLevel.GoToNextLevel();
			_clicked = true;
		}
	}
}
