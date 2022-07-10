using UnityEngine;

public class ScoresLabel : MonoBehaviour
{
	private UILabel _label;

	private bool isHunger;

	private string scoreLocalize;

	private void Start()
	{
		isHunger = Defs.isHunger;
		base.gameObject.SetActive(Defs.IsSurvival || Defs.isCOOP || isHunger);
		_label = GetComponent<UILabel>();
		scoreLocalize = ((!isHunger) ? LocalizationStore.Key_0190 : LocalizationStore.Key_0351);
	}

	private void Update()
	{
		if (isHunger)
		{
			GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
			_label.text = string.Format("{0}", (array != null) ? (array.Length - 1) : 0);
		}
		else
		{
			_label.text = string.Format("{0}", GlobalGameController.Score);
		}
	}
}
