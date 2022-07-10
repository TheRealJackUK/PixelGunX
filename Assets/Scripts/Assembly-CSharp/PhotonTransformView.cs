using UnityEngine;

[AddComponentMenu("Photon Networking/Photon Transform View")]
[RequireComponent(typeof(PhotonView))]
public class PhotonTransformView : MonoBehaviour, IPunObservable
{
	[SerializeField]
	private PhotonTransformViewPositionModel m_PositionModel = new PhotonTransformViewPositionModel();

	[SerializeField]
	private PhotonTransformViewRotationModel m_RotationModel = new PhotonTransformViewRotationModel();

	[SerializeField]
	private PhotonTransformViewScaleModel m_ScaleModel = new PhotonTransformViewScaleModel();

	private PhotonTransformViewPositionControl m_PositionControl;

	private PhotonTransformViewRotationControl m_RotationControl;

	private PhotonTransformViewScaleControl m_ScaleControl;

	private PhotonView m_PhotonView;

	private bool m_ReceivedNetworkUpdate;

	private void Awake()
	{
		m_PhotonView = GetComponent<PhotonView>();
		m_PositionControl = new PhotonTransformViewPositionControl(m_PositionModel);
		m_RotationControl = new PhotonTransformViewRotationControl(m_RotationModel);
		m_ScaleControl = new PhotonTransformViewScaleControl(m_ScaleModel);
	}

	private void Update()
	{
		if (!(m_PhotonView == null) && !m_PhotonView.isMine && PhotonNetwork.connected)
		{
			UpdatePosition();
			UpdateRotation();
			UpdateScale();
		}
	}

	private void UpdatePosition()
	{
		if (m_PositionModel.SynchronizeEnabled && m_ReceivedNetworkUpdate)
		{
			base.transform.localPosition = m_PositionControl.UpdatePosition(base.transform.localPosition);
		}
	}

	private void UpdateRotation()
	{
		if (m_RotationModel.SynchronizeEnabled && m_ReceivedNetworkUpdate)
		{
			base.transform.localRotation = m_RotationControl.GetRotation(base.transform.localRotation);
		}
	}

	private void UpdateScale()
	{
		if (m_ScaleModel.SynchronizeEnabled && m_ReceivedNetworkUpdate)
		{
			base.transform.localScale = m_ScaleControl.GetScale(base.transform.localScale);
		}
	}

	public void SetSynchronizedValues(Vector3 speed, float turnSpeed)
	{
		m_PositionControl.SetSynchronizedValues(speed, turnSpeed);
	}

	public void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
	{
		m_PositionControl.OnPhotonSerializeView(base.transform.localPosition, stream, info);
		m_RotationControl.OnPhotonSerializeView(base.transform.localRotation, stream, info);
		m_ScaleControl.OnPhotonSerializeView(base.transform.localScale, stream, info);
		if (!m_PhotonView.isMine && m_PositionModel.DrawErrorGizmo)
		{
			DoDrawEstimatedPositionError();
		}
		if (stream.isReading)
		{
			m_ReceivedNetworkUpdate = true;
		}
	}

	private void DoDrawEstimatedPositionError()
	{
		Vector3 networkPosition = m_PositionControl.GetNetworkPosition();
		Debug.DrawLine(networkPosition, base.transform.position, Color.red, 2f);
		Debug.DrawLine(base.transform.position, base.transform.position + Vector3.up, Color.green, 2f);
		Debug.DrawLine(networkPosition, networkPosition + Vector3.up, Color.red, 2f);
	}
}
