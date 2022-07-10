using UnityEngine;

internal sealed class AdjustSpriteToLabel : MonoBehaviour
{
	public UILabel label;

	[Range(0f, 100f)]
	public float padding = 30f;

	private UISprite _sprite;

	private void Start()
	{
		_sprite = GetComponent<UISprite>();
		if (label == null)
		{
			label = base.transform.parent.GetComponent<UILabel>();
		}
		if (_sprite == null)
		{
			Debug.LogWarning("sprite == null");
		}
		if (label == null)
		{
			Debug.LogWarning("label == null");
		}
	}

	private void Update()
	{
		if (!(_sprite == null) && !(label == null))
		{
			_sprite.transform.localPosition = new Vector3(padding + 0.5f * (float)label.width, 0f, 0f);
		}
	}
}
