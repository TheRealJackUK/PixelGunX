using System.Collections.Generic;
using UnityEngine;

public class InMemoryKeeper : MonoBehaviour
{
	public List<GameObject> objectsToKeepInMemory = new List<GameObject>();

	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		objectsToKeepInMemory.Add(Resources.Load<GameObject>("Rocket"));
		objectsToKeepInMemory.AddRange(Resources.LoadAll<GameObject>("Rays/"));
		objectsToKeepInMemory.AddRange(Resources.LoadAll<GameObject>("Explosions/"));
	}
}
