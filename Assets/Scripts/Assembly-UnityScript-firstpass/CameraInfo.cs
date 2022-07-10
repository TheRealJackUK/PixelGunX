using System;
using UnityEngine;

[Serializable]
[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Image Effects/Camera Info")]
public class CameraInfo : MonoBehaviour
{
	public DepthTextureMode currentDepthMode;

	public RenderingPath currentRenderPath;

	public int recognizedPostFxCount;

	public virtual void Main()
	{
	}
}
