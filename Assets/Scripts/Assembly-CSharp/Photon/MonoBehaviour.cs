using UnityEngine;

namespace Photon
{
	public class MonoBehaviour : UnityEngine.MonoBehaviour
	{
		public PhotonView photonView
		{
			get
			{
				return PhotonView.Get(this);
			}
		}

		public new PhotonView networkView
		{
			get
			{
				Debug.LogWarning("Why are you still using networkView? should be PhotonView?");
				return PhotonView.Get(this);
			}
		}
	}
}
