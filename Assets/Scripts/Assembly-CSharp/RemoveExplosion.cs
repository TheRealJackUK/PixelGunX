using System.Reflection;
using UnityEngine;

internal sealed class RemoveExplosion : MonoBehaviour
{
	private void Start()
	{
		float num = ((!(base.GetComponent<ParticleSystem>() != null)) ? 0.1f : base.GetComponent<ParticleSystem>().duration);
		if ((bool)base.GetComponent<AudioSource>() && base.GetComponent<AudioSource>().enabled && Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().Play();
		}
		Invoke("Remove", 7f);
	}

	[Obfuscation(Exclude = true)]
	private void Remove()
	{
		Object.Destroy(base.gameObject);
	}
}
