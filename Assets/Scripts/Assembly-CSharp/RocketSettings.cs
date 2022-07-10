using UnityEngine;

public class RocketSettings : MonoBehaviour
{
	public enum TypeFlyRocket
	{
		Rocket,
		Grenade,
		Bullet,
		MegaBullet,
		Autoaim,
		Bomb
	}

	public WeaponSounds.TypeDead typeDead = WeaponSounds.TypeDead.explosion;

	public TypeFlyRocket typeFly;

	public Player_move_c.TypeKills typeKilsIconChat = Player_move_c.TypeKills.explosion;

	public Vector3 sizeBoxCollider = new Vector3(0.15f, 0.15f, 0.75f);
}
