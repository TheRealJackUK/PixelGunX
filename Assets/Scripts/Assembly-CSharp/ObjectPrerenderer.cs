using UnityEngine;

public class ObjectPrerenderer : MonoBehaviour
{
	public Camera activeCamera;

	private RenderTexture _rt;

	public bool FinishPrerendering;

	private GameObject _enemiesToRender;

	private void Awake()
	{
		_rt = new RenderTexture(32, 32, 24);
		_rt.Create();
		activeCamera.targetTexture = _rt;
		activeCamera.useOcclusionCulling = false;
	}

	public void Render_()
	{
		activeCamera.Render();
		RenderTexture.active = _rt;
		activeCamera.targetTexture = null;
		RenderTexture.active = null;
	}
}
