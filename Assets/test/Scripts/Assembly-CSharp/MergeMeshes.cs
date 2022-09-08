using UnityEngine;

public class MergeMeshes : MonoBehaviour
{
	public enum PostMerge
	{
		DisableRenderers = 0,
		DestroyRenderers = 1,
		DisableGameObjects = 2,
		DestroyGameObjects = 3,
	}

	public Material material;
	public PostMerge afterMerging;
}
