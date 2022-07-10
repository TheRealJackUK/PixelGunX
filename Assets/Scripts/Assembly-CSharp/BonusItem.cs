using UnityEngine;

public sealed class BonusItem : MonoBehaviour
{
	private Player_move_c playerMoveC;

	private GameObject player;

	public bool isKilled;

	public AudioClip itemUp;

	public PhotonView photonView;

	private bool isMulti;

	private bool isInet;

	private bool oldIsMaster;

	private WeaponManager _weaponManager;

	private bool isCOOP;

	public int type;

	public double currentTime;

	public double timeKill = -1.0;

	public bool isTimeBonus;

	private void Awake()
	{
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		isCOOP = Defs.isCOOP;
		photonView = GetComponent<PhotonView>();
	}

	private void Start()
	{
		_weaponManager = WeaponManager.sharedManager;
		if (!Defs.isMulti)
		{
			player = GameObject.FindGameObjectWithTag("Player");
			playerMoveC = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
			return;
		}
		player = _weaponManager.myPlayer;
		if (player != null)
		{
			playerMoveC = player.GetComponent<SkinName>().playerMoveC;
		}
	}

	public void SynchTimeKillBonus(double _time)
	{
		photonView.RPC("SynchTimeKillBonusRPC", PhotonTargets.AllBuffered, _time);
	}

	[RPC]
	public void SynchTimeKillBonusRPC(double _time)
	{
		isTimeBonus = true;
		if (Defs.isInet)
		{
			timeKill = _time + 15.0;
		}
		else
		{
			timeKill = Network.time + 15.0;
		}
		base.gameObject.tag = "TimeBonus";
	}

	private void Update()
	{
		currentTime = PhotonNetwork.time;
		if (isMulti)
		{
			if (!oldIsMaster && PhotonNetwork.isMasterClient && isKilled)
			{
				PhotonNetwork.Destroy(base.gameObject);
				return;
			}
			oldIsMaster = PhotonNetwork.isMasterClient;
		}
		bool flag = false;
		if ((isTimeBonus && Defs.isInet && PhotonNetwork.time > timeKill && PhotonNetwork.isMasterClient && !isKilled) || (isTimeBonus && !Defs.isInet && Network.time > timeKill))
		{
			flag = true;
		}
		if (isMulti && (player == null || playerMoveC == null))
		{
			player = _weaponManager.myPlayer;
			if (player != null)
			{
				playerMoveC = _weaponManager.myPlayerMoveC;
			}
		}
		float num = ((!(player != null)) ? 10000000f : Vector3.SqrMagnitude(base.transform.position - player.transform.position));
		if (!isKilled && playerMoveC != null && !playerMoveC.isKilled && ((type == 0 && num < 4f && playerMoveC != null && playerMoveC.NeedAmmo()) || (type != 0 && num < 4f)))
		{
			if (type == 0)
			{
				if (!_weaponManager.AddAmmo(-1))
				{
					GlobalGameController.Score += Defs.ScoreForSurplusAmmo;
				}
				if (Defs.isSoundFX)
				{
					playerMoveC.gameObject.GetComponent<AudioSource>().PlayOneShot(itemUp);
				}
				if (Defs.isMulti)
				{
					playerMoveC.ShowBonuseParticle(Player_move_c.TypeBonuses.Ammo);
				}
			}
			if (type == 1)
			{
				if (playerMoveC.CurHealth == playerMoveC.MaxHealth && (!isMulti || isCOOP))
				{
					GlobalGameController.Score += 100;
				}
				playerMoveC.CurHealth = playerMoveC.MaxHealth;
				if (Defs.isSoundFX)
				{
					playerMoveC.gameObject.GetComponent<AudioSource>().PlayOneShot(itemUp);
				}
				if (Defs.isMulti)
				{
					playerMoveC.ShowBonuseParticle(Player_move_c.TypeBonuses.Health);
				}
			}
			if (type == 2)
			{
				if (playerMoveC.curArmor + 1f > playerMoveC.MaxArmor)
				{
					if (!isMulti || isCOOP)
					{
						GlobalGameController.Score += 100;
					}
				}
				else
				{
					playerMoveC.curArmor += 1f;
				}
				if (Defs.isSoundFX)
				{
					playerMoveC.gameObject.GetComponent<AudioSource>().PlayOneShot(itemUp);
				}
				if (Defs.isMulti)
				{
					playerMoveC.ShowBonuseParticle(Player_move_c.TypeBonuses.Armor);
				}
			}
			if (type == 4 && Storager.getInt("GrenadeID", false) < Defs2.MaxGrenadeCount)
			{
				if (Defs.isHunger)
				{
					Defs.countGrenadeInHunger++;
				}
				else
				{
					Storager.setInt("GrenadeID", Storager.getInt("GrenadeID", false) + 1, false);
				}
				if (Defs.isSoundFX)
				{
					playerMoveC.gameObject.GetComponent<AudioSource>().PlayOneShot(itemUp);
				}
				if (Defs.isMulti)
				{
					playerMoveC.ShowBonuseParticle(Player_move_c.TypeBonuses.Grenade);
				}
			}
			isKilled = true;
			flag = true;
		}
		if (flag)
		{
			if (isMulti && isInet)
			{
				photonView.RPC("DestroyBonusRPC", PhotonTargets.AllBuffered);
			}
			else
			{
				Object.Destroy(base.gameObject);
			}
		}
	}

	[RPC]
	public void DestroyBonusRPC()
	{
		isKilled = true;
		if (PhotonNetwork.isMasterClient)
		{
			PhotonNetwork.Destroy(base.gameObject);
		}
		else
		{
			base.transform.position = new Vector3(0f, -10000f, 0f);
		}
	}
}
