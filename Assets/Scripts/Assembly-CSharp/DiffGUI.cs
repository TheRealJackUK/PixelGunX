using UnityEngine;

public class DiffGUI : MonoBehaviour
{
	public GUIStyle buttons;

	public Texture fon;

	public Texture[] instr = new Texture[0];

	private int _curInd = 1;

	private void Start()
	{
		buttons.fontSize = Mathf.RoundToInt(16f * Defs.Coef);
		_curInd = PlayerPrefs.GetInt(Defs.DiffSett, 1);
	}

	private void OnGUI()
	{
		GUI.depth = -100;
		Rect position = new Rect((float)Screen.width - (float)fon.width * Defs.Coef, (float)Screen.height - (float)fon.height * Defs.Coef, (float)fon.width * Defs.Coef, (float)fon.height * Defs.Coef);
		GUI.DrawTexture(position, fon);
		float num = (float)buttons.normal.background.width * Defs.Coef;
		float num2 = (float)buttons.normal.background.height * Defs.Coef;
		float num3 = 14f * Defs.Coef;
		Rect position2 = new Rect(position.x + position.width - num3 - num - Defs.BottomOffs * Defs.Coef, position.y + position.height - num3 - num2 * 3f - Defs.BottomOffs * Defs.Coef, num, num2 * 3f);
		int num4 = GUI.SelectionGrid(position2, _curInd, new string[3] { "Easy", "Medium", "Hard" }, 1, buttons);
		if (num4 != _curInd)
		{
			ButtonClickSound.Instance.PlayClick();
			_curInd = num4;
			PlayerPrefs.SetInt(Defs.DiffSett, _curInd);
			Defs.diffGame = _curInd;
		}
		Rect position3 = new Rect(position2.x - (float)instr[_curInd].width * Defs.Coef, position.y, (float)instr[_curInd].width * Defs.Coef, (float)instr[_curInd].height * Defs.Coef);
		GUI.DrawTexture(position3, instr[_curInd]);
	}
}
