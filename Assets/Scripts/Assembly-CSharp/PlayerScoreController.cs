using System.Collections.Generic;
using UnityEngine;

public class PlayerScoreController : MonoBehaviour
{
	public int currentScore;

	public string[] addScoreString = new string[3]
	{
		string.Empty,
		string.Empty,
		string.Empty
	};

	public int sumScore;

	public float[] timerAddScoreShow = new float[3];

	public float maxTimerMessage = 2f;

	public float maxTimerSumMessage = 4f;

	private float timeOldHeadShot;

	private List<string> pictNameList = new List<string>();

	private float timeShowPict;

	private float minTimeShowPict = 1f;

	private Dictionary<string, AudioClip> clips = new Dictionary<string, AudioClip>();

	private void Start()
	{
		if (Defs.isMulti && ((Defs.isInet && !GetComponent<PhotonView>().isMine) || (!Defs.isInet && !base.GetComponent<NetworkView>().isMine)))
		{
			base.enabled = false;
			return;
		}
		foreach (KeyValuePair<string, string> item in PlayerEventScoreController.audioClipNameOnEvent)
		{
			string value = item.Value;
			AudioClip audioClip = Resources.Load("ScoreEventSounds/" + value) as AudioClip;
			if (audioClip != null)
			{
				clips.Add(item.Key, audioClip);
			}
		}
	}

	public void AddScoreOnEvent(PlayerEventScoreController.ScoreEvent _event, float _koef = 1f)
	{
		if (Application.isEditor)
		{
			Debug.Log(_event.ToString());
		}
		if ((_event == PlayerEventScoreController.ScoreEvent.deadHeadShot || _event == PlayerEventScoreController.ScoreEvent.deadHeadShot) && Time.time - timeOldHeadShot < 1.5f)
		{
			_event = PlayerEventScoreController.ScoreEvent.doubleHeadShot;
		}
		int num = (int)((float)PlayerEventScoreController.scoreOnEvent[_event.ToString()] * _koef);
		if (num == 0)
		{
			return;
		}
		currentScore = WeaponManager.sharedManager.myNetworkStartTable.score;
		currentScore += num;
		string text = PlayerEventScoreController.messageOnEvent[_event.ToString()];
		if (!string.IsNullOrEmpty(text))
		{
			AddScoreMessage("+" + num + " " + LocalizationStore.Get(text), num);
		}
		string text2 = PlayerEventScoreController.pictureNameOnEvent[_event.ToString()];
		if (!string.IsNullOrEmpty(text2) && InGameGUI.sharedInGameGUI != null)
		{
			bool flag = true;
			if (text2.Equals("Kill") && WeaponManager.sharedManager.myPlayerMoveC != null && WeaponManager.sharedManager.myPlayerMoveC.multiKill > 0)
			{
				flag = false;
			}
			if (flag && !pictNameList.Contains(text2))
			{
				pictNameList.Add(text2);
			}
		}
		GlobalGameController.Score = currentScore;
		WeaponManager.sharedManager.myNetworkStartTable.score = currentScore;
		WeaponManager.sharedManager.myNetworkStartTable.SynhScore();
	}

	private void AddScoreMessage(string _message, int _addScore)
	{
		addScoreString[2] = addScoreString[1];
		addScoreString[1] = _message;
		if (timerAddScoreShow[0] > 0f)
		{
			sumScore += _addScore;
		}
		else
		{
			sumScore = _addScore;
		}
		addScoreString[0] = sumScore.ToString();
		timerAddScoreShow[2] = timerAddScoreShow[1];
		timerAddScoreShow[1] = maxTimerMessage;
		timerAddScoreShow[0] = maxTimerSumMessage;
	}

	private void Update()
	{
		timeShowPict += Time.deltaTime;
		if (timeShowPict > minTimeShowPict && pictNameList.Count > 0)
		{
			string text = pictNameList[0];
			timeShowPict = 0f;
			InGameGUI.sharedInGameGUI.timerShowScorePict = InGameGUI.sharedInGameGUI.maxTimerShowScorePict;
			InGameGUI.sharedInGameGUI.scorePictName = text;
			if (clips.ContainsKey(text) && Defs.isSoundFX)
			{
				NGUITools.PlaySound(clips[text]);
			}
			pictNameList.RemoveAt(0);
		}
		if (timerAddScoreShow[2] > 0f)
		{
			timerAddScoreShow[2] -= Time.deltaTime;
		}
		if (timerAddScoreShow[1] > 0f)
		{
			timerAddScoreShow[1] -= Time.deltaTime;
		}
		if (timerAddScoreShow[0] > 0f)
		{
			timerAddScoreShow[0] -= Time.deltaTime;
		}
	}
}
