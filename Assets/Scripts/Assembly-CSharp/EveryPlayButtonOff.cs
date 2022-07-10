using Rilisoft;
using UnityEngine;

public class EveryPlayButtonOff : MonoBehaviour
{
	private void Start()
	{
		if ((BuildSettings.BuildTarget == BuildTarget.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon) || BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			base.gameObject.SetActive(false);
		}
	}
}
