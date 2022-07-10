using UnityEngine;

public class Scr : MonoBehaviour
{
	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
	}

	private void Update()
	{
	}
}
