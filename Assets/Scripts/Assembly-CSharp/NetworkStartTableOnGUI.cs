using UnityEngine;

public class NetworkStartTableOnGUI : MonoBehaviour
{
	public NetworkStartTable myTable;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnGUI()
	{
		myTable.MyOnGUI();
	}
}
