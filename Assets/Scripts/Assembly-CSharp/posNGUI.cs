using UnityEngine;

public class posNGUI : MonoBehaviour
{
	private static UIRoot rootObj;

	public static float scaleNGUI;

	public static float heightScreen;

	public static float nachY;

	private void Awake()
	{
		rootObj = GetComponent<UIRoot>();
		heightScreen = Mathf.Min(1366, Mathf.RoundToInt(768f * (float)Screen.height / (float)Screen.width));
		scaleNGUI = 2f / heightScreen;
		nachY = rootObj.transform.position.y;
		rootObj.gameObject.transform.localScale = new Vector3(scaleNGUI, scaleNGUI, scaleNGUI);
	}

	public static Vector3 getPosNGUI(Vector3 tekPos)
	{
		return new Vector3(getPosX(tekPos.x), getPosY(tekPos.y), tekPos.z * scaleNGUI);
	}

	public static float getPosX(float tekPosX)
	{
		return (tekPosX - 384f) * scaleNGUI;
	}

	public static float getPosY(float tekPosY)
	{
		return nachY + (0f - tekPosY + heightScreen * 0.5f) * scaleNGUI;
	}

	public static Vector3 getSize(Vector3 tekSize)
	{
		return new Vector3(tekSize.x * scaleNGUI, tekSize.y * scaleNGUI, tekSize.z * scaleNGUI);
	}

	public static float getSizeWidth(float tekWidth)
	{
		return tekWidth * scaleNGUI;
	}

	public static float getSizeHeight(float tekHeight)
	{
		return tekHeight * scaleNGUI;
	}

	public static Vector3 getEulerZ(float tekUgol)
	{
		return new Vector3(0f, 0f, tekUgol);
	}

	public static void setFillRect(GameObject thisGameObj)
	{
		thisGameObj.transform.localScale = new Vector3(770f, heightScreen + 2f, 1f);
	}
}
