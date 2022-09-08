using UnityEngine;

internal class FirstPersonControlSharp : MonoBehaviour
{
	public Transform cameraPivot;
	public float inAirMultiplier;
	public Vector2 rotationSpeed;
	public float tiltPositiveYAxis;
	public float tiltNegativeYAxis;
	public float tiltXAxisMinimum;
	public string myIp;
	public GameObject playerGameObject;
	public int typeAnim;
	public GameObject camPlayer;
	public bool isMine;
	public AudioClip jumpClip;
	public float gravityMultiplier;
	public bool ninjaJumpUsed;
}
