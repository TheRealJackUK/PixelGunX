using UnityEngine;

public class TextureSetter : MonoBehaviour
{
	public string TextureName;

	private void Awake()
	{
		SkipPresser.SkipPressed += SetTexture;
		SkipTrainingButton.SkipTrClosed += UnsetTexture;
	}

	private void OnDestroy()
	{
		SkipPresser.SkipPressed -= SetTexture;
		SkipTrainingButton.SkipTrClosed -= UnsetTexture;
	}

	private void SetTexture()
	{
		if (!string.IsNullOrEmpty(TextureName))
		{
			string path = ResPath.Combine("SkipTraining", TextureName);
			GetComponent<UITexture>().mainTexture = Resources.Load(path) as Texture;
		}
	}

	private void UnsetTexture()
	{
		GetComponent<UITexture>().mainTexture = null;
	}
}
