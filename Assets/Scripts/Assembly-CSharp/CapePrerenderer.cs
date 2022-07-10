using UnityEngine;

public class CapePrerenderer : MonoBehaviour
{
	public Camera activeCamera;

	private RenderTexture _rt;

	public bool FinishPrerendering;

	private GameObject _enemiesToRender;

	private void Awake()
	{
		_rt = new RenderTexture(512, 512, 24);
		_rt.Create();
		activeCamera.targetTexture = _rt;
		activeCamera.useOcclusionCulling = false;
	}

	public Texture Render_()
	{
		activeCamera.Render();
		RenderTexture.active = _rt;
		activeCamera.targetTexture = null;
		RenderTexture.active = null;
		Object.Destroy(base.transform.parent.gameObject);
		return _rt;
	}
}
