using UnityEngine;

internal sealed class Shoot : MonoBehaviour
{
	public float Range = 1000f;

	public Transform _transform;

	public GameObject bullet;

	private GameObject _bulletSpawnPoint;

	public int lives = 100;

	private void Start()
	{
		_bulletSpawnPoint = GameObject.Find("BulletSpawnPoint");
	}

	[PunRPC]
	private void Popal(PhotonView Popal, PhotonMessageInfo info)
	{
		Debug.Log(string.Concat(Popal, " ", base.gameObject.transform.GetComponent<PhotonView>().viewID, " ", info.sender));
	}

	public void shootS()
	{
		Debug.Log("Shot!!" + base.transform.position);
		Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0f));
		RaycastHit hitInfo;
		if (Physics.Raycast(ray, out hitInfo, 100f, Player_move_c._ShootRaycastLayerMask))
		{
			Debug.Log("Hit!");
			if (hitInfo.collider.gameObject.transform.CompareTag("Enemy") && Defs.isMulti)
			{
				base.GetComponent<PhotonView>().RPC("Popal", PhotonTargets.All, hitInfo.collider.gameObject.transform.GetComponent<PhotonView>().viewID);
			}
		}
	}
}
