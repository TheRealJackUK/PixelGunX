using UnityEngine;

public sealed class CustomCapePicker : MonoBehaviour
{
	public bool shouldLoadTexture = true;

	private void Start()
	{
		if (shouldLoadTexture)
		{
			Texture capeUserTexture = SkinsController.capeUserTexture;
			capeUserTexture.filterMode = FilterMode.Point;
			Player_move_c.SetTextureRecursivelyFrom(base.gameObject, capeUserTexture, new GameObject[0]);
		}
	}
}
