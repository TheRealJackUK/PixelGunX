using UnityEngine;

internal sealed class crossHair : MonoBehaviour
{
	public Texture2D crossHairTexture;

	private Rect crossHairPosition;

	private Pauser pauser;

	private Player_move_c playerMoveC;

	private PhotonView photonView;

	private void Start()
	{
		photonView = PhotonView.Get(this);
		if ((((!Defs.isInet && base.GetComponent<NetworkView>().isMine) || (Defs.isInet && photonView.isMine)) && Defs.isMulti) || !Defs.isMulti)
		{
			crossHairPosition = new Rect((Screen.width - crossHairTexture.width * Screen.height / 640) / 2, (Screen.height - crossHairTexture.height * Screen.height / 640) / 2, crossHairTexture.width * Screen.height / 640, crossHairTexture.height * Screen.height / 640);
			pauser = GameObject.FindGameObjectWithTag("GameController").GetComponent<Pauser>();
			playerMoveC = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
		}
	}

	private void OnGUI()
	{
		if (((((!Defs.isInet && base.GetComponent<NetworkView>().isMine) || (Defs.isInet && photonView.isMine)) && Defs.isMulti) || !Defs.isMulti) && !pauser.paused)
		{
			GUI.DrawTexture(crossHairPosition, crossHairTexture);
		}
	}
}
