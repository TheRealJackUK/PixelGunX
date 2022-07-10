using UnityEngine;

public class BackToFriendsFromClans : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		MenuBackgroundMusic.keepPlaying = true;
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "Friends";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}
}
