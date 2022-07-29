using UnityEngine;

public class CameraSceneController : MonoBehaviour
{
	public static CameraSceneController sharedController;

	private Vector3 posCam = new Vector3(17f, 11f, 17f);

	private Quaternion rotateCam = Quaternion.Euler(new Vector3(39f, 226f, 0f));

	private Transform myTransform;

	public RPG_Camera killCamController;

	private void Awake()
	{
		sharedController = this;
		myTransform = base.transform;
		if (Application.loadedLevelName.Equals("Mine"))
		{
			posCam = new Vector3(-29.63f, 11.26f, -44.48f);
			rotateCam = Quaternion.Euler(new Vector3(19.67534f, 30.00002f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Slender_Multy"))
		{
			posCam = new Vector3(31.82355f, 5.959687f, 37.378f);
			rotateCam = Quaternion.Euler(new Vector3(36.08264f, -110.1159f, 2.307983f));
		}
		else if (Application.loadedLevelName.Equals("Barge"))
		{
			posCam = new Vector3(15.81f, 28.87f, -30.12f);
			rotateCam = Quaternion.Euler(new Vector3(17.69f, -52.65f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Pizza"))
		{
			posCam = new Vector3(12.6f, 3.97f, 8.02f);
			rotateCam = Quaternion.Euler(new Vector3(22.97f, -131.3437f, 4.19f));
		}
		else if (Application.loadedLevelName.Equals("Bota"))
		{
			posCam = new Vector3(-60f, 21.53f, 14.56f);
			rotateCam = Quaternion.Euler(new Vector3(15f, 118.2999f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Paradise"))
		{
			posCam = new Vector3(18.48f, 0.54f, 19.47f);
			rotateCam = Quaternion.Euler(new Vector3(-6.089722f, 132.2656f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Day_D"))
		{
			posCam = new Vector3(31.15712f, 7.614257f, -4.818801f);
			rotateCam = Quaternion.Euler(new Vector3(8.619919f, -123.1408f, 0f));
		}
		else if (Application.loadedLevelName.Equals("NuclearCity"))
		{
			posCam = new Vector3(-27.71493f, 9.460411f, -2.671694f);
			rotateCam = Quaternion.Euler(new Vector3(12.17598f, 83.05725f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Cube"))
		{
			posCam = new Vector3(-14.35343f, 12.65811f, 14.04167f);
			rotateCam = Quaternion.Euler(new Vector3(36.88519f, 135f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Train"))
		{
			posCam = new Vector3(21f, 16f, -12f);
			rotateCam = Quaternion.Euler(new Vector3(25f, -60f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Sniper"))
		{
			posCam = new Vector3(20f, 10f, 25f);
			rotateCam = Quaternion.Euler(new Vector3(3f, -41f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Supermarket"))
		{
			posCam = new Vector3(75f, 7f, -30f);
			rotateCam = Quaternion.Euler(new Vector3(3f, -75f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Pumpkins"))
		{
			posCam = new Vector3(-14f, 14f, 19f);
			rotateCam = Quaternion.Euler(new Vector3(16f, 126f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Christmas_Town"))
		{
			posCam = new Vector3(-14f, 14f, 19f);
			rotateCam = Quaternion.Euler(new Vector3(16f, 126f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Christmas_Town_Night"))
		{
			posCam = new Vector3(-14f, 14f, 19f);
			rotateCam = Quaternion.Euler(new Vector3(16f, 126f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Maze"))
		{
			posCam = new Vector3(23f, 5.25f, -20.5f);
			rotateCam = Quaternion.Euler(new Vector3(33f, -50f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Cementery"))
		{
			posCam = new Vector3(17f, 11f, 17f);
			rotateCam = Quaternion.Euler(new Vector3(39f, 226f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Hospital"))
		{
			posCam = new Vector3(9.5f, 3.2f, 9.5f);
			rotateCam = Quaternion.Euler(new Vector3(25f, -140f, 0f));
		}
		else if (Application.loadedLevelName.Equals("City"))
		{
			posCam = new Vector3(17f, 11f, 17f);
			rotateCam = Quaternion.Euler(new Vector3(39f, 226f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Jail"))
		{
			posCam = new Vector3(13.5f, 2.9f, 3.1f);
			rotateCam = Quaternion.Euler(new Vector3(11f, -66f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Gluk"))
		{
			posCam = new Vector3(17f, 11f, 17f);
			rotateCam = Quaternion.Euler(new Vector3(39f, 226f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Pool"))
		{
			posCam = new Vector3(-17.36495f, 5.448204f, -5.605346f);
			rotateCam = Quaternion.Euler(new Vector3(31.34471f, 31.34471f, 0.2499542f));
		}
		else if (Application.loadedLevelName.Equals("Slender"))
		{
			posCam = new Vector3(31.82355f, 5.959687f, 37.378f);
			rotateCam = Quaternion.Euler(new Vector3(36.08264f, -110.1159f, 2.307983f));
		}
		else if (Application.loadedLevelName.Equals("Castle"))
		{
			posCam = new Vector3(-12.3107f, 4.9f, 0.2716838f);
			rotateCam = Quaternion.Euler(new Vector3(26.89935f, 89.99986f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Bridge"))
		{
			posCam = new Vector3(-14.22702f, 14.6011f, -74.93485f);
			rotateCam = Quaternion.Euler(new Vector3(24.68127f, 160f, 0.2789154f));
		}
		else if (Application.loadedLevelName.Equals("Farm"))
		{
			posCam = new Vector3(22.4933f, 16.03175f, -35.17904f);
			rotateCam = Quaternion.Euler(new Vector3(29.99995f, -28.62347f, 0f));
		}
		else if (Application.loadedLevelName.Equals("School"))
		{
			posCam = new Vector3(-19.52079f, 2.868755f, -19.50274f);
			rotateCam = Quaternion.Euler(new Vector3(14.96701f, 40.79106f, 1.266037f));
		}
		else if (Application.loadedLevelName.Equals("Sky_islands"))
		{
			posCam = new Vector3(-3.111776f, 21.94557f, 25.31594f);
			rotateCam = Quaternion.Euler(new Vector3(41.94537f, -143.1731f, 6.383652f));
		}
		else if (Application.loadedLevelName.Equals("Dust"))
		{
			posCam = new Vector3(-12.67253f, 6.92115f, 28.89415f);
			rotateCam = Quaternion.Euler(new Vector3(28.46265f, 147.2818f, 0.2389221f));
		}
		else if (Application.loadedLevelName.Equals("Utopia"))
		{
			posCam = new Vector3(-10.62854f, 10.01794f, -51.20456f);
			rotateCam = Quaternion.Euler(new Vector3(13.26845f, 16.31204f, 1.440735f));
		}
		else if (Application.loadedLevelName.Equals("Assault"))
		{
			posCam = new Vector3(19.36158f, 19.61019f, -24.24763f);
			rotateCam = Quaternion.Euler(new Vector3(35.9299f, -11.80757f, -1.581451f));
		}
		else if (Application.loadedLevelName.Equals("Aztec"))
		{
			posCam = new Vector3(-6.693532f, 11.69715f, 24.21659f);
			rotateCam = Quaternion.Euler(new Vector3(41.08192f, 134.5497f, -1.380188f));
		}
		else if (Application.loadedLevelName.Equals("Parkour"))
		{
			posCam = new Vector3(-7.352654f, 113.1507f, -29.85653f);
			rotateCam = Quaternion.Euler(new Vector3(11.99559f, -16.57709f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Coliseum_MP"))
		{
			posCam = new Vector3(14.32691f, 9.814805f, -20.59482f);
			rotateCam = Quaternion.Euler(new Vector3(11.60112f, -34.35773f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Hungry"))
		{
			posCam = new Vector3(-17.00313f, 26.73884f, 25.21794f);
			rotateCam = Quaternion.Euler(new Vector3(45f, 133.77f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Hungry_Night"))
		{
			posCam = new Vector3(-17.00313f, 26.73884f, 25.21794f);
			rotateCam = Quaternion.Euler(new Vector3(45f, 133.77f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Estate"))
		{
			posCam = new Vector3(-10.54591f, 12.52175f, 54.25265f);
			rotateCam = Quaternion.Euler(new Vector3(20.6673f, 147.7978f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Ranch"))
		{
			posCam = new Vector3(6.929729f, 11.63932f, -12.79686f);
			rotateCam = Quaternion.Euler(new Vector3(32.05518f, -26.4068f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Space"))
		{
			posCam = new Vector3(-26.34445f, 12.08921f, 50.52678f);
			rotateCam = Quaternion.Euler(new Vector3(8.542023f, 144.9284f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Hungry_2"))
		{
			posCam = new Vector3(-14.88988f, 13.45897f, -13.3518f);
			rotateCam = Quaternion.Euler(new Vector3(38.7506f, 63.3826f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Portal"))
		{
			posCam = new Vector3(-12.11895f, 13.50075f, 39.97712f);
			rotateCam = Quaternion.Euler(new Vector3(22.95538f, 147.1387f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Two_Castles"))
		{
			posCam = new Vector3(-15.43661f, 1.870193f, -30.82652f);
			rotateCam = Quaternion.Euler(new Vector3(-17.48395f, -89.99988f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Ships"))
		{
			posCam = new Vector3(-14.70674f, 30.88849f, 31.48288f);
			rotateCam = Quaternion.Euler(new Vector3(24.59309f, 119.2478f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Ships_Night"))
		{
			posCam = new Vector3(-14.70674f, 30.88849f, 31.48288f);
			rotateCam = Quaternion.Euler(new Vector3(24.59309f, 119.2478f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Gluk_3"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Matrix"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Lean_Matrix"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Tatuan"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("ChinaPand"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("PiratIsland"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("emperors_palace"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Secret_Base"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Christmas_dinner"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Helicarrier"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("train_robbery"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Candyland"))
		{
			posCam = new Vector3(11.4502f, 20.29328f, 19.8833f);
			rotateCam = Quaternion.Euler(new Vector3(32.95062f, -149.9998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Ants"))
		{
			posCam = new Vector3(-5.627228f, 20.49741f, 15.93793f);
			rotateCam = Quaternion.Euler(new Vector3(26.42534f, 149.9999f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Hill"))
		{
			posCam = new Vector3(43.99298f, 18.35728f, 44.65937f);
			rotateCam = Quaternion.Euler(new Vector3(14.39806f, -135f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Heaven"))
		{
			posCam = new Vector3(0.8211896f, 22.78858f, 22.34459f);
			rotateCam = Quaternion.Euler(new Vector3(14.99997f, -180f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Underwater"))
		{
			posCam = new Vector3(17.0383f, 16.49174f, -22.72179f);
			rotateCam = Quaternion.Euler(new Vector3(11.31189f, -130.5916f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Knife"))
		{
			posCam = new Vector3(-8.960545f, 10.92595f, 28.56895f);
			rotateCam = Quaternion.Euler(new Vector3(-8.730835f, 14.99998f, 0f));
		}
		else if (Application.loadedLevelName.Equals("DevScene"))
		{
			posCam = new Vector3(-48.1f, 53.7483f, -57.59f);
			rotateCam = Quaternion.Euler(new Vector3(25.468f, 42.66f, 0f));
		}
		else if (Application.loadedLevelName.Equals("Pool_Abandoned"))
		{
			posCam = new Vector3(-48.1f, 53.7483f, -57.59f);
			rotateCam = Quaternion.Euler(new Vector3(25.468f, 42.66f, 0f));
		}
		else if (Application.loadedLevelName.Equals("actualgame"))
		{
			posCam = new Vector3(-48.8773f, 36.3f, 113.7431f);
			rotateCam = Quaternion.Euler(new Vector3(1.703643f, 154.7453f, 5.338445e-08f));
		}
		else if (Application.loadedLevelName.Equals("AntsButBetter"))
		{
			posCam = new Vector3(110.8f, -57.8f, -95f);
			rotateCam = Quaternion.Euler(new Vector3(10.3435f, -147.5507f, 6.509081e-07f));
		}
		else if (Application.loadedLevelName.Equals("Pool_Brian"))
		{
			posCam = new Vector3(-48.1f, 53.7483f, -57.59f);
			rotateCam = Quaternion.Euler(new Vector3(25.468f, 42.66f, 0f));
		}
		else if (Application.loadedLevelName.Equals("epilepsy"))
		{
			posCam = new Vector3(31.82355f, 5.959687f, 37.378f);
			rotateCam = Quaternion.Euler(new Vector3(36.08264f, -110.1159f, 2.307983f));
		}
		else if (Application.loadedLevelName.Equals("RealCube"))
		{
			posCam = new Vector3(1831.6f, 1669.7f, 2127.6f);
			rotateCam = Quaternion.Euler(new Vector3(-4.781133e-05f, -45.00003f, 29.99994f));
		}
	}

	private void Start()
	{
		myTransform.position = posCam;
		myTransform.rotation = rotateCam;
		killCamController.enabled = false;
	}

	public void SetTargetKillCam(Transform target = null)
	{
		if (target == null)
		{
			killCamController.enabled = false;
			killCamController.cameraPivot = null;
			myTransform.position = posCam;
			myTransform.rotation = rotateCam;
		}
		else
		{
			killCamController.enabled = true;
			killCamController.cameraPivot = target;
			myTransform.position = target.position;
			myTransform.rotation = target.rotation;
		}
	}

	private void Update()
	{
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
