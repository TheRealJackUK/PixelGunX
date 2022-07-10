using UnityEngine;

public class PlayerDeadStackController : MonoBehaviour
{
	public static PlayerDeadStackController sharedController;

	public PlayerDeadController[] playerDeads;

	private int currentIndexHole;

	private void Start()
	{
		sharedController = this;
		Transform transform = base.transform;
		transform.position = Vector3.zero;
		int childCount = transform.childCount;
		playerDeads = new PlayerDeadController[childCount];
		for (int i = 0; i < childCount; i++)
		{
			playerDeads[i] = transform.GetChild(i).GetComponent<PlayerDeadController>();
		}
	}

	public PlayerDeadController GetCurrentParticle(bool _isUseMine)
	{
		bool flag = true;
		do
		{
			currentIndexHole++;
			if (currentIndexHole >= playerDeads.Length)
			{
				if (!flag)
				{
					return null;
				}
				currentIndexHole = 0;
				flag = false;
			}
		}
		while (playerDeads[currentIndexHole].isUseMine && !_isUseMine);
		return playerDeads[currentIndexHole];
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
