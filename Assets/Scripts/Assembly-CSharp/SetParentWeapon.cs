using System.Reflection;
using UnityEngine;

internal sealed class SetParentWeapon : MonoBehaviour
{
	private bool isMine;

	private bool isInet;

	private bool isMulti;

	private PhotonView photonView;

	private void Start()
	{
		if (Application.loadedLevelName.Equals(Defs.MainMenuScene))
		{
			return;
		}
		isMulti = Defs.isMulti;
		if (isMulti)
		{
			isInet = Defs.isInet;
			photonView = PhotonView.Get(this);
			if (!isInet)
			{
				isMine = base.GetComponent<NetworkView>().isMine;
			}
			else
			{
				isMine = photonView.isMine;
			}
			SetParent();
		}
	}

	[Obfuscation(Exclude = true)]
	private void SetParent()
	{
		int num = -1;
		NetworkPlayer owner = base.GetComponent<NetworkView>().owner;
		if (isInet && (bool)photonView && (bool)photonView && photonView.owner != null)
		{
			num = photonView.owner.ID;
		}
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if ((!isInet || !gameObject.GetComponent<PhotonView>() || gameObject.GetComponent<PhotonView>().owner == null || gameObject.GetComponent<PhotonView>().owner.ID != num) && (isInet || !gameObject.GetComponent<NetworkView>().owner.Equals(owner)))
			{
				continue;
			}
			GameObject playerGameObject = gameObject.GetComponent<SkinName>().playerGameObject;
			Player_move_c component = playerGameObject.GetComponent<Player_move_c>();
			GameObject gameObject2 = null;
			base.transform.position = Vector3.zero;
			if (!base.transform.GetComponent<WeaponSounds>().isMelee)
			{
				foreach (Transform item in base.transform)
				{
					if (item.gameObject.name.Equals("BulletSpawnPoint") && item.childCount >= 0)
					{
						gameObject2 = item.GetChild(0).gameObject;
						if (!isMine)
						{
							WeaponManager.SetGunFlashActive(gameObject2, false);
						}
						break;
					}
				}
			}
			foreach (Transform item2 in playerGameObject.transform)
			{
				item2.parent = null;
				item2.position += -Vector3.up * 1000f;
			}
			base.transform.parent = playerGameObject.transform;
			if (base.transform.Find("BulletSpawnPoint") != null)
			{
				component._bulletSpawnPoint = base.transform.Find("BulletSpawnPoint").gameObject;
			}
			base.transform.localPosition = new Vector3(0f, -1.7f, 0f);
			base.transform.rotation = playerGameObject.transform.rotation;
			GameObject gameObject3 = playerGameObject.transform.parent.gameObject;
			if (gameObject3 != null)
			{
				Player_move_c.SetTextureRecursivelyFrom(playerGameObject.transform.parent.gameObject, component._skin, Player_move_c.GetStopObjFromPlayer(gameObject3));
			}
			return;
		}
		Invoke("SetParent", 0.1f);
	}
}
