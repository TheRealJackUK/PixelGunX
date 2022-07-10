using UnityEngine;

public class EnemiesLabel : MonoBehaviour
{
	private UILabel _label;

	private ZombieCreator _zombieCreator;

	private string enemiesLocalize;

	private void Start()
	{
		bool flag = !Defs.isMulti;
		base.gameObject.SetActive(flag);
		if (flag)
		{
			_label = GetComponent<UILabel>();
			_zombieCreator = GameObject.FindGameObjectWithTag("GameController").GetComponent<ZombieCreator>();
			enemiesLocalize = LocalizationStore.Key_0193;
		}
	}

	private void Update()
	{
		_label.text = string.Format("{0}", ZombieCreator.NumOfEnemisesToKill - _zombieCreator.NumOfDeadZombies);
	}
}
