using UnityEngine;

public class PreviewSkin : MonoBehaviour
{
	public Camera previewCamera;

	private Vector2 touchPosition;

	private bool isTapDown;

	private GameObject selectedGameObject;

	private float sideMargin = 100f;

	private float topBottMargins = 120f;

	private Rect swipeZone;

	private Vector3 rememberedScale;

	private Vector3 rememberedBodyOffs;

	private void Start()
	{
		swipeZone = new Rect(sideMargin, topBottMargins, (float)Screen.width - sideMargin * 2f, (float)Screen.height - topBottMargins * 2f);
	}

	private void Update()
	{
		if (!isTapDown && Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began || Input.GetMouseButtonDown(0))
		{
			if (Application.isMobilePlatform)
			{
				touchPosition = ((Input.touchCount <= 0) ? new Vector2(Input.mousePosition.x, Input.mousePosition.y) : Input.GetTouch(0).position);
				if (swipeZone.Contains(touchPosition))
				{
					isTapDown = true;
					selectedGameObject = GameObjectOnTouch(touchPosition);
					if (selectedGameObject != null)
					{
						Highlight(selectedGameObject);
					}
				}
				return;
			} else {
				touchPosition = (Vector2)Input.mousePosition;
				isTapDown = true;
				selectedGameObject = GameObjectOnTouch(touchPosition);
				if (selectedGameObject != null)
				{
					Highlight(selectedGameObject);
				}
				Debug.LogError("called here with a mouse pos of " + (Vector2)Input.mousePosition + ", the selected gameobject is " + GameObjectOnTouch(touchPosition));
				return;
			}
		}
		if (Application.isMobilePlatform && isTapDown && Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Moved)
		{
			if (Application.isMobilePlatform)
			{
				float num = ((Input.touchCount <= 0) ? (touchPosition.x - Input.mousePosition.x) : (touchPosition.x - Input.GetTouch(0).position.x));
				if (selectedGameObject != null && Mathf.Abs(num) > 2f)
				{
					Unhighlight(selectedGameObject);
					selectedGameObject = null;
				}
				else
				{
					float num2 = 0.5f;
					base.transform.Rotate(0f, num2 * num, 0f, Space.Self);
					touchPosition = ((Input.touchCount <= 0) ? new Vector2(Input.mousePosition.x, Input.mousePosition.y) : Input.GetTouch(0).position);
				}
			} else {
				float num = Input.mousePosition.x;
				if (selectedGameObject != null && Mathf.Abs(num) > 2f)
				{
					Unhighlight(selectedGameObject);
					selectedGameObject = null;
				}
				else
				{
					float num2 = 0.5f;
					base.transform.Rotate(0f, num2 * num, 0f, Space.Self);
					touchPosition = Input.mousePosition;
				}
			}
		}
		if (Application.isMobilePlatform && Input.touchCount <= 0 || Application.isMobilePlatform && (Input.GetTouch(0).phase != TouchPhase.Ended && Input.GetTouch(0).phase != TouchPhase.Canceled))
		{
			return;
		}
		if (selectedGameObject != null)
		{
			ButtonClickSound.Instance.PlayClick();
			Unhighlight(selectedGameObject);
			if (SkinEditorController.sharedController != null)
			{
				SkinEditorController.sharedController.SelectPart(selectedGameObject.name);
			}
			selectedGameObject = null;
		}
		isTapDown = false;
	}

	public GameObject GameObjectOnTouch(Vector2 touchPosition)
	{
		RaycastHit hitInfo;
		if (Physics.Raycast(previewCamera.ScreenPointToRay(new Vector3(touchPosition.x, touchPosition.y, 0f)), out hitInfo))
		{
			return hitInfo.collider.gameObject;
		}
		return null;
	}

	public void Highlight(GameObject go)
	{
		MeshRenderer component = go.GetComponent<MeshRenderer>();
		if (!(component == null))
		{
			Color color = component.materials[0].color;
			component.materials[0].color = new Color(color.r, color.g, color.b, 0.6f);
		}
	}

	public void Unhighlight(GameObject go)
	{
		MeshRenderer component = go.GetComponent<MeshRenderer>();
		if (!(component == null))
		{
			Color color = component.materials[0].color;
			component.materials[0].color = new Color(color.r, color.g, color.b, 1f);
		}
	}

	private void OnEnable()
	{
		Debug.Log("OnEnabled()");
		isTapDown = false;
		selectedGameObject = null;
	}

	private void OnDisable()
	{
		Debug.Log("OnDisabled()");
		isTapDown = false;
		selectedGameObject = null;
	}
}
