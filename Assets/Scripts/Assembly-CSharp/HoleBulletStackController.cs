using UnityEngine;

public class HoleBulletStackController : MonoBehaviour
{
	public static HoleBulletStackController sharedController;

	public HoleScript[] holes;

	private int currentIndexHole;

	private void Start()
	{
		sharedController = this;
		base.transform.position = Vector3.zero;
		GameObject[] array = GameObject.FindGameObjectsWithTag("HoleBullet");
		holes = new HoleScript[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			holes[i] = array[i].GetComponent<HoleScript>();
		}
	}

	public HoleScript GetCurrentHole(bool _isUseMine)
	{
		bool flag = true;
		do
		{
			currentIndexHole++;
			if (currentIndexHole >= holes.Length)
			{
				if (!flag)
				{
					return null;
				}
				currentIndexHole = 0;
				flag = false;
			}
		}
		while (holes[currentIndexHole].isUseMine && !_isUseMine);
		return holes[currentIndexHole];
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
