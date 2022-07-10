using Rilisoft;
using UnityEngine;

public class EnderButton : MonoBehaviour
{
	private void Start()
	{
		if ((BuildSettings.BuildTarget != BuildTarget.iPhone && (BuildSettings.BuildTarget != BuildTarget.Android || Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon)) || !Defs.EnderManAvailable)
		{
			base.gameObject.SetActive(false);
		}
	}

	private void Update()
	{
	}
}
