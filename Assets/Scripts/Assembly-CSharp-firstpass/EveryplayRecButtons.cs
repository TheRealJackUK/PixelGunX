using System.Collections.Generic;
using UnityEngine;

public class EveryplayRecButtons : MonoBehaviour
{
	public enum ButtonsOrigin
	{
		TopLeft,
		TopRight,
		BottomLeft,
		BottomRight
	}

	private class TextureAtlasSrc
	{
		public Rect atlasRect;

		public Rect normalizedAtlasRect;

		public TextureAtlasSrc(int width, int height, int x, int y, float scale)
		{
			atlasRect.x = x + 2;
			atlasRect.y = y + 2;
			atlasRect.width = (float)width * scale;
			atlasRect.height = (float)height * scale;
			normalizedAtlasRect.width = (float)width / 256f;
			normalizedAtlasRect.height = (float)height / 256f;
			normalizedAtlasRect.x = atlasRect.x / 256f;
			normalizedAtlasRect.y = 1f - (atlasRect.y + (float)height) / 256f;
		}
	}

	private class Button
	{
		public bool enabled;

		public Rect screenRect;

		public TextureAtlasSrc bg;

		public TextureAtlasSrc title;

		public ButtonTapped onTap;

		public Button(TextureAtlasSrc bg, TextureAtlasSrc title, ButtonTapped buttonTapped)
		{
			enabled = true;
			this.bg = bg;
			this.title = title;
			screenRect.width = bg.atlasRect.width;
			screenRect.height = bg.atlasRect.height;
			onTap = buttonTapped;
		}
	}

	private class ToggleButton : Button
	{
		public TextureAtlasSrc toggleOn;

		public TextureAtlasSrc toggleOff;

		public bool toggled;

		public ToggleButton(TextureAtlasSrc bg, TextureAtlasSrc title, ButtonTapped buttonTapped, TextureAtlasSrc toggleOn, TextureAtlasSrc toggleOff)
			: base(bg, title, buttonTapped)
		{
			this.toggleOn = toggleOn;
			this.toggleOff = toggleOff;
		}
	}

	private delegate void ButtonTapped();

	private const int atlasWidth = 256;

	private const int atlasHeight = 256;

	private const int atlasPadding = 2;

	public Texture2D atlasTexture;

	public ButtonsOrigin origin;

	public Vector2 containerMargin = new Vector2(16f, 16f);

	private Vector2 containerOffset = Vector2.zero;

	private float containerScaling = 1f;

	private int buttonTitleHorizontalMargin = 16;

	private int buttonTitleVerticalMargin = 20;

	private int buttonMargin = 8;

	private bool faceCamPermissionGranted;

	private bool startFaceCamWhenPermissionGranted;

	private TextureAtlasSrc editVideoAtlasSrc;

	private TextureAtlasSrc faceCamAtlasSrc;

	private TextureAtlasSrc openEveryplayAtlasSrc;

	private TextureAtlasSrc shareVideoAtlasSrc;

	private TextureAtlasSrc startRecordingAtlasSrc;

	private TextureAtlasSrc stopRecordingAtlasSrc;

	private TextureAtlasSrc facecamToggleOnAtlasSrc;

	private TextureAtlasSrc facecamToggleOffAtlasSrc;

	private TextureAtlasSrc bgHeaderAtlasSrc;

	private TextureAtlasSrc bgFooterAtlasSrc;

	private TextureAtlasSrc bgAtlasSrc;

	private TextureAtlasSrc buttonAtlasSrc;

	private Button shareVideoButton;

	private Button editVideoButton;

	private Button openEveryplayButton;

	private Button startRecordingButton;

	private Button stopRecordingButton;

	private ToggleButton faceCamToggleButton;

	private Button tappedButton;

	private List<Button> visibleButtons;

	private void Awake()
	{
		containerScaling = GetScalingByResolution();
		editVideoAtlasSrc = new TextureAtlasSrc(112, 19, 0, 0, containerScaling);
		faceCamAtlasSrc = new TextureAtlasSrc(103, 19, 116, 0, containerScaling);
		openEveryplayAtlasSrc = new TextureAtlasSrc(178, 23, 0, 23, containerScaling);
		shareVideoAtlasSrc = new TextureAtlasSrc(134, 19, 0, 50, containerScaling);
		startRecordingAtlasSrc = new TextureAtlasSrc(171, 23, 0, 73, containerScaling);
		stopRecordingAtlasSrc = new TextureAtlasSrc(169, 23, 0, 100, containerScaling);
		facecamToggleOnAtlasSrc = new TextureAtlasSrc(101, 42, 0, 127, containerScaling);
		facecamToggleOffAtlasSrc = new TextureAtlasSrc(101, 42, 101, 127, containerScaling);
		bgHeaderAtlasSrc = new TextureAtlasSrc(256, 9, 0, 169, containerScaling);
		bgFooterAtlasSrc = new TextureAtlasSrc(256, 9, 0, 169, containerScaling);
		bgAtlasSrc = new TextureAtlasSrc(256, 6, 0, 178, containerScaling);
		buttonAtlasSrc = new TextureAtlasSrc(220, 64, 0, 190, containerScaling);
		buttonTitleHorizontalMargin = Mathf.RoundToInt((float)buttonTitleHorizontalMargin * containerScaling);
		buttonTitleVerticalMargin = Mathf.RoundToInt((float)buttonTitleVerticalMargin * containerScaling);
		buttonMargin = Mathf.RoundToInt((float)buttonMargin * containerScaling);
		shareVideoButton = new Button(buttonAtlasSrc, shareVideoAtlasSrc, ShareVideo);
		editVideoButton = new Button(buttonAtlasSrc, editVideoAtlasSrc, EditVideo);
		openEveryplayButton = new Button(buttonAtlasSrc, openEveryplayAtlasSrc, OpenEveryplay);
		startRecordingButton = new Button(buttonAtlasSrc, startRecordingAtlasSrc, StartRecording);
		stopRecordingButton = new Button(buttonAtlasSrc, stopRecordingAtlasSrc, StopRecording);
		faceCamToggleButton = new ToggleButton(buttonAtlasSrc, faceCamAtlasSrc, FaceCamToggle, facecamToggleOnAtlasSrc, facecamToggleOffAtlasSrc);
		visibleButtons = new List<Button>();
		bgFooterAtlasSrc.normalizedAtlasRect.y = bgFooterAtlasSrc.normalizedAtlasRect.y + bgFooterAtlasSrc.normalizedAtlasRect.height;
		bgFooterAtlasSrc.normalizedAtlasRect.height = 0f - bgFooterAtlasSrc.normalizedAtlasRect.height;
		SetButtonVisible(startRecordingButton, true);
		SetButtonVisible(openEveryplayButton, true);
		SetButtonVisible(faceCamToggleButton, true);
		if (!Everyplay.IsRecordingSupported())
		{
			startRecordingButton.enabled = false;
			stopRecordingButton.enabled = false;
		}
		Everyplay.RecordingStarted += RecordingStarted;
		Everyplay.RecordingStopped += RecordingStopped;
		Everyplay.ReadyForRecording += ReadyForRecording;
		Everyplay.FaceCamRecordingPermission += FaceCamRecordingPermission;
	}

	private void Destroy()
	{
		Everyplay.RecordingStarted -= RecordingStarted;
		Everyplay.RecordingStopped -= RecordingStopped;
		Everyplay.ReadyForRecording -= ReadyForRecording;
		Everyplay.FaceCamRecordingPermission -= FaceCamRecordingPermission;
	}

	private void SetButtonVisible(Button button, bool visible)
	{
		if (visibleButtons.Contains(button))
		{
			if (!visible)
			{
				visibleButtons.Remove(button);
			}
		}
		else if (visible)
		{
			visibleButtons.Add(button);
		}
	}

	private void ReplaceVisibleButton(Button button, Button replacementButton)
	{
		int num = visibleButtons.IndexOf(button);
		if (num >= 0)
		{
			visibleButtons[num] = replacementButton;
		}
	}

	private void StartRecording()
	{
		Everyplay.StartRecording();
	}

	private void StopRecording()
	{
		Everyplay.StopRecording();
	}

	private void RecordingStarted()
	{
		ReplaceVisibleButton(startRecordingButton, stopRecordingButton);
		SetButtonVisible(shareVideoButton, false);
		SetButtonVisible(editVideoButton, false);
		SetButtonVisible(faceCamToggleButton, false);
	}

	private void RecordingStopped()
	{
		ReplaceVisibleButton(stopRecordingButton, startRecordingButton);
		SetButtonVisible(shareVideoButton, true);
		SetButtonVisible(editVideoButton, true);
		SetButtonVisible(faceCamToggleButton, true);
	}

	private void ReadyForRecording(bool enabled)
	{
		startRecordingButton.enabled = enabled;
		stopRecordingButton.enabled = enabled;
	}

	private void FaceCamRecordingPermission(bool granted)
	{
		faceCamPermissionGranted = granted;
		if (startFaceCamWhenPermissionGranted)
		{
			faceCamToggleButton.toggled = granted;
			Everyplay.FaceCamStartSession();
			if (Everyplay.FaceCamIsSessionRunning())
			{
				startFaceCamWhenPermissionGranted = false;
			}
		}
	}

	private void FaceCamToggle()
	{
		if (faceCamPermissionGranted)
		{
			faceCamToggleButton.toggled = !faceCamToggleButton.toggled;
			if (faceCamToggleButton.toggled)
			{
				if (!Everyplay.FaceCamIsSessionRunning())
				{
					Everyplay.FaceCamStartSession();
				}
			}
			else if (Everyplay.FaceCamIsSessionRunning())
			{
				Everyplay.FaceCamStopSession();
			}
		}
		else
		{
			Everyplay.FaceCamRequestRecordingPermission();
			startFaceCamWhenPermissionGranted = true;
		}
	}

	private void OpenEveryplay()
	{
		Everyplay.Show();
	}

	private void EditVideo()
	{
		Everyplay.PlayLastRecording();
	}

	private void ShareVideo()
	{
		Everyplay.ShowSharingModal();
	}

	private void Update()
	{
		Touch[] touches = Input.touches;
		for (int i = 0; i < touches.Length; i++)
		{
			Touch touch = touches[i];
			if (touch.phase == TouchPhase.Began)
			{
				foreach (Button visibleButton in visibleButtons)
				{
					if (visibleButton.screenRect.Contains(new Vector2(touch.position.x - containerOffset.x, (float)Screen.height - touch.position.y - containerOffset.y)))
					{
						tappedButton = visibleButton;
					}
				}
			}
			else if (touch.phase == TouchPhase.Ended)
			{
				foreach (Button visibleButton2 in visibleButtons)
				{
					if (visibleButton2.screenRect.Contains(new Vector2(touch.position.x - containerOffset.x, (float)Screen.height - touch.position.y - containerOffset.y)) && visibleButton2.onTap != null)
					{
						visibleButton2.onTap();
					}
				}
				tappedButton = null;
			}
			else if (touch.phase == TouchPhase.Canceled)
			{
				tappedButton = null;
			}
		}
	}

	private void OnGUI()
	{
		if (Event.current.type.Equals(EventType.Repaint))
		{
			int containerHeight = CalculateContainerHeight();
			UpdateContainerOffset(containerHeight);
			DrawBackround(containerHeight);
			DrawButtons();
		}
	}

	private void DrawTexture(float x, float y, float width, float height, Texture2D texture, Rect uvRect)
	{
		x += containerOffset.x;
		y += containerOffset.y;
		GUI.DrawTextureWithTexCoords(new Rect(x, y, width, height), texture, uvRect, true);
	}

	private void DrawButtons()
	{
		foreach (Button visibleButton in visibleButtons)
		{
			if (visibleButton.enabled)
			{
				DrawButton(visibleButton, (tappedButton != visibleButton) ? Color.white : Color.gray);
			}
			else
			{
				DrawButton(visibleButton, new Color(0.5f, 0.5f, 0.5f, 0.3f));
			}
		}
	}

	private void DrawBackround(int containerHeight)
	{
		DrawTexture(0f, 0f, bgHeaderAtlasSrc.atlasRect.width, bgHeaderAtlasSrc.atlasRect.height, atlasTexture, bgHeaderAtlasSrc.normalizedAtlasRect);
		DrawTexture(0f, bgHeaderAtlasSrc.atlasRect.height, bgAtlasSrc.atlasRect.width, (float)containerHeight - bgHeaderAtlasSrc.atlasRect.height - bgFooterAtlasSrc.atlasRect.height, atlasTexture, bgAtlasSrc.normalizedAtlasRect);
		DrawTexture(0f, (float)containerHeight - bgFooterAtlasSrc.atlasRect.height, bgFooterAtlasSrc.atlasRect.width, bgFooterAtlasSrc.atlasRect.height, atlasTexture, bgFooterAtlasSrc.normalizedAtlasRect);
	}

	private void DrawButton(Button button, Color tintColor)
	{
		Color color = GUI.color;
		bool flag = typeof(ToggleButton).IsAssignableFrom(button.GetType());
		if (flag)
		{
			ToggleButton toggleButton = (ToggleButton)button;
			if (button != null)
			{
				float x = button.screenRect.x + button.screenRect.width - toggleButton.toggleOn.atlasRect.width;
				float y = button.screenRect.y + button.screenRect.height / 2f - toggleButton.toggleOn.atlasRect.height / 2f;
				TextureAtlasSrc textureAtlasSrc = ((!toggleButton.toggled) ? toggleButton.toggleOff : toggleButton.toggleOn);
				GUI.color = tintColor;
				DrawTexture(x, y, textureAtlasSrc.atlasRect.width, textureAtlasSrc.atlasRect.height, atlasTexture, textureAtlasSrc.normalizedAtlasRect);
				GUI.color = color;
			}
		}
		else
		{
			GUI.color = tintColor;
			DrawTexture(button.screenRect.x, button.screenRect.y, button.bg.atlasRect.width, button.bg.atlasRect.height, atlasTexture, button.bg.normalizedAtlasRect);
			GUI.color = color;
		}
		float num = ((!flag) ? buttonTitleHorizontalMargin : 0);
		if (!button.enabled)
		{
			GUI.color = tintColor;
		}
		DrawTexture(button.screenRect.x + num, button.screenRect.y + (float)buttonTitleVerticalMargin, button.title.atlasRect.width, button.title.atlasRect.height, atlasTexture, button.title.normalizedAtlasRect);
		if (!button.enabled)
		{
			GUI.color = color;
		}
	}

	private int CalculateContainerHeight()
	{
		float num = 0f;
		float num2 = bgHeaderAtlasSrc.atlasRect.height + ((float)(buttonMargin * 2) - bgHeaderAtlasSrc.atlasRect.height);
		foreach (Button visibleButton in visibleButtons)
		{
			visibleButton.screenRect.x = (bgAtlasSrc.atlasRect.width - visibleButton.screenRect.width) / 2f;
			visibleButton.screenRect.y = num2;
			num2 += (float)buttonMargin + visibleButton.screenRect.height;
			num += (float)buttonMargin + visibleButton.screenRect.height;
		}
		return Mathf.RoundToInt(num + bgHeaderAtlasSrc.atlasRect.height + bgFooterAtlasSrc.atlasRect.height);
	}

	private void UpdateContainerOffset(int containerHeight)
	{
		if (origin == ButtonsOrigin.TopRight)
		{
			containerOffset.x = (float)Screen.width - containerMargin.x * containerScaling - bgAtlasSrc.atlasRect.width;
			containerOffset.y = containerMargin.y * containerScaling;
		}
		else if (origin == ButtonsOrigin.BottomLeft)
		{
			containerOffset.x = containerMargin.x * containerScaling;
			containerOffset.y = (float)Screen.height - containerMargin.y * containerScaling - (float)containerHeight;
		}
		else if (origin == ButtonsOrigin.BottomRight)
		{
			containerOffset.x = (float)Screen.width - containerMargin.x * containerScaling - bgAtlasSrc.atlasRect.width;
			containerOffset.y = (float)Screen.height - containerMargin.y * containerScaling - (float)containerHeight;
		}
		else
		{
			containerOffset.x = containerMargin.x * containerScaling;
			containerOffset.y = containerMargin.y * containerScaling;
		}
	}

	private float GetScalingByResolution()
	{
		int num = Mathf.Max(Screen.height, Screen.width);
		int num2 = Mathf.Min(Screen.height, Screen.width);
		if (num < 640 || (num == 1024 && num2 == 768))
		{
			return 0.5f;
		}
		return 1f;
	}
}
