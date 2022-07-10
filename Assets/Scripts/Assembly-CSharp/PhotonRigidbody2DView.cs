using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
[RequireComponent(typeof(PhotonView))]
[AddComponentMenu("Photon Networking/Photon Rigidbody 2D View")]
public class PhotonRigidbody2DView : MonoBehaviour
{
	[SerializeField]
	private bool m_SynchronizeVelocity = true;

	[SerializeField]
	private bool m_SynchronizeAngularVelocity = true;

	private Rigidbody2D m_Body;

	private void Awake()
	{
		m_Body = GetComponent<Rigidbody2D>();
	}

	private void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
	{
		if (stream.isWriting)
		{
			if (m_SynchronizeVelocity)
			{
				stream.SendNext(m_Body.velocity);
			}
			if (m_SynchronizeAngularVelocity)
			{
				stream.SendNext(m_Body.angularVelocity);
			}
		}
		else
		{
			if (m_SynchronizeVelocity)
			{
				m_Body.velocity = (Vector2)stream.ReceiveNext();
			}
			if (m_SynchronizeAngularVelocity)
			{
				m_Body.angularVelocity = (float)stream.ReceiveNext();
			}
		}
	}
}
