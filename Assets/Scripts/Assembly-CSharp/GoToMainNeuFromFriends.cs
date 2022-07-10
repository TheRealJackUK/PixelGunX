using UnityEngine;

internal sealed class GoToMainNeuFromFriends : MonoBehaviour
{
	private bool firstFrame = true;

	private bool _escapePressed;

	private void HandleClick()
	{
		ButtonClickSound.Instance.PlayClick();
		MenuBackgroundMusic.keepPlaying = true;
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = Defs.MainMenuScene;
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	private void OnPress(bool isDown)
	{
		if (isDown)
		{
			firstFrame = false;
		}
		else if (!firstFrame)
		{
			HandleClick();
		}
	}

	private void Update()
	{
		if (_escapePressed)
		{
			_escapePressed = false;
			HandleClick();
		}
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_escapePressed = true;
		}
	}
}
