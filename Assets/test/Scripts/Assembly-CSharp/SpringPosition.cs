using UnityEngine;

public class SpringPosition : MonoBehaviour
{
	public Vector3 target;
	public float strength;
	public bool worldSpace;
	public bool ignoreTimeScale;
	public bool updateScrollView;
	[SerializeField]
	private GameObject gameObject_0;
	[SerializeField]
	public string string_0;
}
