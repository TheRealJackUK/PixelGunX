using UnityEngine;

public class ToggleFix : MonoBehaviour
{
	public UIToggle toggle;

	public UIButton button;

	public UISprite background;

	public UISprite checkmark;

	public bool oldState;

	public bool firstUpdate = true;

	private void Start()
	{
		button = GetComponent<UIButton>();
	}

	private void Update()
	{
		if (button.state != UIButtonColor.State.Pressed)
		{
			checkmark.color = new Color(checkmark.color.r, checkmark.color.g, checkmark.color.b, (!toggle.value) ? 0f : 1f);
			background.color = new Color(background.color.r, background.color.g, background.color.b, (!toggle.value) ? 1f : 0f);
		}
	}

	private void OnPress()
	{
		checkmark.color = new Color(checkmark.color.r, checkmark.color.g, checkmark.color.b, 0f);
		background.color = new Color(background.color.r, background.color.g, background.color.b, 1f);
	}
}
