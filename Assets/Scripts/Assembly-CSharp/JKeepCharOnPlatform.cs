using System.Collections;
using UnityEngine;

public class JKeepCharOnPlatform : MonoBehaviour
{
	public struct Data
	{
		public CharacterController ctrl;

		public Transform t;

		public float yOffset;

		public Data(CharacterController ctrl, Transform t, float yOffset)
		{
			this.ctrl = ctrl;
			this.t = t;
			this.yOffset = yOffset;
		}
	}

	public float verticalOffset = 0.5f;

	private Hashtable onPlatform = new Hashtable();

	private Vector3 lastPos;

	private void OnTriggerEnter(Collider other)
	{
		CharacterController characterController = other.GetComponent(typeof(CharacterController)) as CharacterController;
		if (!(characterController == null))
		{
			Transform t = other.transform;
			float yOffset = characterController.height / 2f - characterController.center.y + verticalOffset;
			Data data = new Data(characterController, t, yOffset);
			onPlatform.Add(other.transform, data);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		onPlatform.Remove(other.transform);
	}

	private void Start()
	{
		lastPos = base.transform.position;
	}

	private void Update()
	{
		Vector3 position = base.transform.position;
		float y = position.y;
		Vector3 vector = position - lastPos;
		float y2 = vector.y;
		vector.y = 0f;
		lastPos = position;
		foreach (DictionaryEntry item in onPlatform)
		{
			Data data = (Data)item.Value;
			float y3 = data.ctrl.velocity.y;
			if (y3 <= 0f || y3 <= y2)
			{
				Vector3 position2 = data.t.position;
				position2.y = y + data.yOffset;
				position2 += vector;
				data.t.position = position2;
			}
		}
	}
}
