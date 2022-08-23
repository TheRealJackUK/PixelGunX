using Photon;
using UnityEngine;

[RequireComponent(typeof(PhotonView))]
public class MoveByKeys : Photon.MonoBehaviour
{
	public float Speed = 10f;

	public float JumpForce = 200f;

	public float JumpTimeout = 0.5f;

	private bool isSprite;

	private float jumpingTime;

	private Rigidbody body;

	private Rigidbody2D body2d;

	public void Start()
	{
		isSprite = GetComponent<SpriteRenderer>() != null;
		body2d = GetComponent<Rigidbody2D>();
		body = GetComponent<Rigidbody>();
	}

	public void FixedUpdate()
	{
		if (!base.photonView.isMine)
		{
			return;
		}
		if (Input.GetKey(KeyCode.A))
		{
			base.transform.position += Vector3.left * (Speed * Time.deltaTime);
		}
		if (Input.GetKey(KeyCode.D))
		{
			base.transform.position += Vector3.right * (Speed * Time.deltaTime);
		}
		if (jumpingTime <= 0f)
		{
			if ((body != null || body2d != null) && Input.GetKey(KeyCode.Space))
			{
				jumpingTime = JumpTimeout;
				Vector2 vector = Vector2.up * JumpForce;
				if (body2d != null)
				{
					body2d.AddForce(vector);
				}
				else if (body != null)
				{
					body.AddForce(vector);
				}
			}
		}
		else
		{
			jumpingTime -= Time.deltaTime;
		}
		if (!isSprite)
		{
			if (Input.GetKey(KeyCode.W))
			{
				base.transform.position += Vector3.forward * (Speed * Time.deltaTime);
			}
			if (Input.GetKey(KeyCode.S))
			{
				base.transform.position -= Vector3.forward * (Speed * Time.deltaTime);
			}
		}
	}
}
