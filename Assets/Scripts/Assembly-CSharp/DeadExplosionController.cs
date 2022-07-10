using UnityEngine;

public class DeadExplosionController : MonoBehaviour
{
	public SkinnedMeshRenderer mySkinRenderer;

	public float timeAfteAnim = 0.5f;

	public float startTimerAnim = 0.5f;

	private float timeAnim = -1f;

	public void StartAnim()
	{
		timeAnim = startTimerAnim + timeAfteAnim;
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
