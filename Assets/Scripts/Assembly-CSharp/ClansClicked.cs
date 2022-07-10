using UnityEngine;

public class ClansClicked : MonoBehaviour
{
	private void OnClick()
	{
		ButtonClickSound.Instance.PlayClick();
		MenuBackgroundMusic.keepPlaying = true;
		LoadConnectScene.textureToShow = Resources.Load<Texture>("Friends_Loading");
		LoadConnectScene.sceneToLoad = "Clans";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}
}
