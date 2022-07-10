using UnityEngine;

[AddComponentMenu("NGUI/Examples/Lag Rotation")]
public class LagRotation : MonoBehaviour
{
	public int updateOrder;

	public float speed = 10f;

	public bool ignoreTimeScale;

	private Transform mTrans;

	private Quaternion mRelative;

	private Quaternion mAbsolute;

	private void OnEnable()
	{
		mTrans = base.transform;
		mRelative = mTrans.localRotation;
		mAbsolute = mTrans.rotation;
	}

	private void Update()
	{
		Transform parent = mTrans.parent;
		if (parent != null)
		{
			float num = ((!ignoreTimeScale) ? Time.deltaTime : RealTime.deltaTime);
			mAbsolute = Quaternion.Slerp(mAbsolute, parent.rotation * mRelative, num * speed);
			mTrans.rotation = mAbsolute;
		}
	}
}
