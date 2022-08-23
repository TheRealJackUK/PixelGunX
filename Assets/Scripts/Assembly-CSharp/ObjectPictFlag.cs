using System;
using UnityEngine;

internal sealed class ObjectPictFlag : MonoBehaviour
{
	public Camera cameraToUse;

	public Camera cam;

	public Transform target;

	public Vector3 posLabel;

	private Transform camTransform;

	public bool isBaza;

	public FlagController myFlagController;

	public void SetTexture(Texture _texture)
	{
		GetComponent<GUITexture>().texture = _texture;
	}

	private void Update()
	{
		try
		{
			cam = NickLabelController.currentCamera;
			if (cam != null)
			{
				camTransform = cam.transform;
			}
			if (target == null || cam == null)
			{
				if (Time.frameCount % 60 == 0)
				{
					Debug.Log("target == null");
				}
				base.transform.position = new Vector3(-1000f, -1000f, -1000f);
				return;
			}
			posLabel = cam.WorldToViewportPoint(target.position);
			if (posLabel.z >= 0f)
			{
				base.transform.position = posLabel;
			}
			else
			{
				base.transform.position = new Vector3(-1000f, -1000f, -1000f);
			}
			if (isBaza && myFlagController.isBaza && myFlagController.flagModel.activeInHierarchy)
			{
				base.transform.position = new Vector3(-1000f, -1000f, -1000f);
			}
			if (!isBaza && !target.parent.GetComponent<FlagController>().flagModel.activeInHierarchy)
			{
				base.transform.position = new Vector3(-1000f, -1000f, -1000f);
			}
		}
		catch (Exception ex)
		{
			Debug.Log("Exception in ObjectLabel: " + ex);
		}
	}
}
