using UnityEngine;

public class TimeLabel : MonoBehaviour
{
	private UILabel _label;

	private void Start()
	{
		base.gameObject.SetActive(Defs.isMulti);
		_label = GetComponent<UILabel>();
	}

	private void Update()
	{
		if ((bool)InGameGUI.sharedInGameGUI && (bool)_label)
		{
			_label.text = InGameGUI.sharedInGameGUI.timeLeft();
		}
	}
}
