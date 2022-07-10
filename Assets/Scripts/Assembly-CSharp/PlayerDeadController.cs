using UnityEngine;

public sealed class PlayerDeadController : MonoBehaviour
{
	private float liveTime = -1f;

	private float maxliveTime = 4.8f;

	public bool isUseMine;

	private Transform myTransform;

	public Animation myAnimation;

	public GameObject[] playerDeads;

	public DeadEnergyController deadEnergyController;

	public DeadExplosionController deadExplosionController;

	private void Start()
	{
		myTransform = base.transform;
		myTransform.position = new Vector3(-10000f, -10000f, -10000f);
	}

	private void TryPlayAudioClip(GameObject obj)
	{
		if (Defs.isSoundFX)
		{
			AudioSource component = obj.GetComponent<AudioSource>();
			if (!(component == null))
			{
				component.Play();
			}
		}
	}

	public void StartShow(Vector3 pos, Quaternion rot, int _typeDead, bool _isUseMine, Texture _skin)
	{
		isUseMine = _isUseMine;
		liveTime = maxliveTime;
		myTransform.position = pos;
		myTransform.rotation = rot;
		switch (_typeDead)
		{
		case 1:
			playerDeads[1].SetActive(true);
			TryPlayAudioClip(playerDeads[1]);
			deadExplosionController.StartAnim();
			break;
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		{
			playerDeads[2].SetActive(true);
			TryPlayAudioClip(playerDeads[2]);
			Color color = new Color(0f, 0.5f, 1f);
			if (_typeDead == 3)
			{
				color = new Color(1f, 0f, 0f);
			}
			if (_typeDead == 4)
			{
				color = new Color(1f, 0f, 0f);
			}
			if (_typeDead == 4)
			{
				color = new Color(1f, 0f, 1f);
			}
			if (_typeDead == 5)
			{
				color = new Color(0f, 0.5f, 1f);
			}
			if (_typeDead == 6)
			{
				color = new Color(1f, 0.91f, 0f);
			}
			if (_typeDead == 7)
			{
				color = new Color(0f, 0.85f, 0f);
			}
			if (_typeDead == 8)
			{
				color = new Color(1f, 0.55f, 0f);
			}
			if (_typeDead == 9)
			{
				color = new Color(1f, 1f, 1f);
			}
			deadEnergyController.StartAnim(color, _skin);
			break;
		}
		default:
			playerDeads[0].SetActive(true);
			break;
		}
	}

	private void Update()
	{
		if (!(liveTime < 0f))
		{
			liveTime -= Time.deltaTime;
			if (liveTime < 0f)
			{
				myTransform.position = new Vector3(-10000f, -10000f, -10000f);
				playerDeads[0].SetActive(false);
				playerDeads[1].SetActive(false);
				playerDeads[2].SetActive(false);
				isUseMine = false;
			}
		}
	}
}
