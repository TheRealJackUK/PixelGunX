using System;
using UnityEngine;

public class GotToNextLevel : MonoBehaviour
{
	private Action OnPlayerAddedAct;

	private GameObject _player;

	private Player_move_c _playerMoveC;

	private bool runLoading;

	private void Awake()
	{
		OnPlayerAddedAct = delegate
		{
			_player = GameObject.FindGameObjectWithTag("Player");
			_playerMoveC = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
		};
		Initializer.PlayerAddedEvent += OnPlayerAddedAct;
	}

	private void OnDestroy()
	{
		Initializer.PlayerAddedEvent -= OnPlayerAddedAct;
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.SetEnablePerfectLabel(false);
		}
	}

	private void Update()
	{
		if (!(_player == null) && !(_playerMoveC == null) && !runLoading && Vector3.SqrMagnitude(base.transform.position - _player.transform.position) < 2.25f)
		{
			runLoading = true;
			Debug.Log("end GlobalGameController.currentLevel " + GlobalGameController.currentLevel);
			if (Defs.isTrainingFlag)
			{
				Storager.setInt(Defs.CoinsAfterTrainingSN, 1, false);
			}
			GoToNextLevel();
			if (InGameGUI.sharedInGameGUI != null)
			{
				InGameGUI.sharedInGameGUI.SetEnablePerfectLabel(true);
			}
		}
	}

	public static void GoToNextLevel()
	{
		if (Defs.isTrainingFlag)
		{
			Storager.setInt(Defs.TrainingCompleted_4_4_Sett, 1, false);
			Defs.isTrainingFlag = false;
			Storager.setInt("GrenadeID", 5, false);
			GlobalGameController.InsideTraining = false;
			PlayerPrefs.Save();
			LevelCompleteLoader.sceneName = Defs.MainMenuScene;
		}
		else
		{
			LevelCompleteLoader.action = null;
			LevelCompleteLoader.sceneName = "LevelComplete";
		}
		AutoFade.LoadLevel("LevelToCompleteProm", 2f, 0f, Color.white);
	}
}
