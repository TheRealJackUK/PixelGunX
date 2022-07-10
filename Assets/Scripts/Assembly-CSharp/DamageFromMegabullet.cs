using UnityEngine;

public class DamageFromMegabullet : MonoBehaviour
{
	public Rocket myRocketScript;

	private void OnTriggerEnter(Collider other)
	{
		if (myRocketScript.isRun && (!Defs.isMulti || myRocketScript.isMine) && !other.gameObject.name.Equals("DamageCollider") && !other.gameObject.CompareTag("CapturePoint") && (Defs.isMulti || (!other.gameObject.tag.Equals("Player") && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player")))) && (!Defs.isMulti || ((!other.gameObject.tag.Equals("Player") || !(other.gameObject == WeaponManager.sharedManager.myPlayer)) && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player") || !(other.transform.parent.gameObject == WeaponManager.sharedManager.myPlayer)))) && (!(other.gameObject.transform.parent != null) || !other.gameObject.transform.parent.gameObject.CompareTag("Untagged")) && (!(other.gameObject.transform.parent == null) || !other.gameObject.CompareTag("Untagged")))
		{
			myRocketScript.Hit(other.gameObject);
		}
	}
}
