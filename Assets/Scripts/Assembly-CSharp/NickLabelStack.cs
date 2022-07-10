using UnityEngine;

public class NickLabelStack : MonoBehaviour
{
	public static NickLabelStack sharedStack;

	public NickLabelController[] lables;

	private int currentIndexLabel;

	private void Awake()
	{
		sharedStack = this;
	}

	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		base.transform.localPosition = Vector3.zero;
		Transform transform = base.transform.GetChild(0).transform;
		base.transform.position = Vector3.zero;
		int childCount = transform.childCount;
		lables = new NickLabelController[childCount];
		for (int i = 0; i < childCount; i++)
		{
			lables[i] = transform.GetChild(i).GetComponent<NickLabelController>();
		}
	}

	public NickLabelController GetNextCurrentLabel()
	{
		base.transform.localPosition = Vector3.zero;
		bool flag = true;
		do
		{
			currentIndexLabel++;
			if (currentIndexLabel >= lables.Length)
			{
				if (!flag)
				{
					return null;
				}
				currentIndexLabel = 0;
				flag = false;
			}
		}
		while (lables[currentIndexLabel].target != null);
		return lables[currentIndexLabel];
	}

	public NickLabelController GetCurrentLabel()
	{
		return lables[currentIndexLabel];
	}

	private void OnDestroy()
	{
		sharedStack = null;
	}
}
