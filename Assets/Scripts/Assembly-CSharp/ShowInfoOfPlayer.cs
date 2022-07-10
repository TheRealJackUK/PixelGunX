using Photon;
using UnityEngine;

[RequireComponent(typeof(PhotonView))]
public class ShowInfoOfPlayer : Photon.MonoBehaviour
{
	private GameObject textGo;

	private TextMesh tm;

	public float CharacterSize;

	public Font font;

	public bool DisableOnOwnObjects;

	private void Start()
	{
		if (font == null)
		{
			font = (Font)Resources.FindObjectsOfTypeAll(typeof(Font))[0];
			Debug.LogWarning("No font defined. Found font: " + font);
		}
		if (tm == null)
		{
			textGo = new GameObject("3d text");
			textGo.transform.parent = base.gameObject.transform;
			textGo.transform.localPosition = Vector3.zero;
			MeshRenderer meshRenderer = textGo.AddComponent<MeshRenderer>();
			meshRenderer.material = font.material;
			tm = textGo.AddComponent<TextMesh>();
			tm.font = font;
			tm.anchor = TextAnchor.MiddleCenter;
			if (CharacterSize > 0f)
			{
				tm.characterSize = CharacterSize;
			}
		}
	}

	private void Update()
	{
		bool flag = !DisableOnOwnObjects || base.photonView.isMine;
		if (textGo != null)
		{
			textGo.SetActive(flag);
		}
		if (flag)
		{
			PhotonPlayer owner = base.photonView.owner;
			if (owner != null)
			{
				tm.text = ((!string.IsNullOrEmpty(owner.name)) ? owner.name : ("player" + owner.ID));
			}
			else if (base.photonView.isSceneView)
			{
				tm.text = "scn";
			}
			else
			{
				tm.text = "n/a";
			}
		}
	}
}
