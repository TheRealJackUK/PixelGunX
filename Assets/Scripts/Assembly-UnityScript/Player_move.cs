using System;
using UnityEngine;

[Serializable]
public class Player_move : MonoBehaviour
{
	public virtual void Start()
	{
		GetComponent<Animation>()["Reload"].layer = 1;
		GetComponent<Animation>().Stop();
	}

	public virtual void Update()
	{
		if (!(Input.GetAxis("Vertical") <= 0.2f))
		{
			GetComponent<Animation>().CrossFade("Walk");
		}
		else if (!(Input.GetAxis("Vertical") >= -0.2f))
		{
			GetComponent<Animation>().CrossFade("Walk");
		}
		else if (!(Input.GetAxis("Horizontal") <= 0.2f))
		{
			GetComponent<Animation>().CrossFade("Walk");
		}
		else if (!(Input.GetAxis("Horizontal") >= -0.2f))
		{
			GetComponent<Animation>().CrossFade("Walk");
		}
		else
		{
			GetComponent<Animation>().CrossFade("Idle");
		}
		if (Input.GetButtonDown("Fire1"))
		{
			GetComponent<Animation>().Stop();
			GetComponent<Animation>().Play("Shoot");
		}
		if (Input.GetKeyDown(KeyCode.R))
		{
			GetComponent<Animation>().Play("Reload");
		}
	}

	public virtual void Main()
	{
	}
}
