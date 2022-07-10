using UnityEngine;

public class DeadEnergyController : MonoBehaviour
{
	public SkinnedMeshRenderer mySkinRenderer;

	public ParticleSystem myParticle;

	public float timeAfteAnim;

	public float startTimerAnim = 1f;

	private float timeAnim = -1f;

	public void StartAnim(Color _color, Texture _skin)
	{
		timeAnim = startTimerAnim + timeAfteAnim;
		mySkinRenderer.material.SetColor("_BurnColor", _color);
		mySkinRenderer.material.SetTexture("_MainTex", _skin);
		myParticle.startColor = _color;
	}

	private void Update()
	{
		if (timeAnim > 0f)
		{
			float value = 1.25f;
			timeAnim -= Time.deltaTime;
			if (timeAnim < startTimerAnim)
			{
				value = -0.25f + 1.5f * timeAnim / startTimerAnim;
			}
			mySkinRenderer.material.SetFloat("_Burn", value);
		}
	}
}
