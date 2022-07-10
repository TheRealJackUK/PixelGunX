using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewLobbyLevelAnimator : MonoBehaviour
{
	public enum CondtionsForShow
	{
		None,
		PromoOffers,
		Premium
	}

	private const int numOFStepsWhenAppearingButton = 25;

	public float buttonAlphaTime = 1f;

	public float timeBetweenShineAndTip = 0.3f;

	public float timeTipShown = 5f;

	public List<GameObject> buttons;

	public List<GameObject> tips;

	public List<GameObject> shines;

	public List<CondtionsForShow> conditions;

	private bool _tapped;

	private void Awake()
	{
		foreach (GameObject button in buttons)
		{
			UISprite component = button.GetComponent<UISprite>();
			component.alpha = 0f;
		}
		foreach (GameObject shine in shines)
		{
			shine.SetActive(false);
		}
		foreach (GameObject tip in tips)
		{
			tip.SetActive(false);
		}
	}

	public void OnMouseDown()
	{
		_tapped = true;
	}

	private IEnumerator Start()
	{
		while (FriendsController.sharedController == null)
		{
			yield return null;
		}
		for (int i = 0; i < buttons.Count; i++)
		{
			bool condition = true;
			if (conditions[i] == CondtionsForShow.Premium)
			{
				condition = Storager.getInt(Defs.PremiumEnabledFromServer, false) == 1;
			}
			else if (conditions[i] == CondtionsForShow.PromoOffers)
			{
				condition = MainMenuController.sharedController != null && MainMenuController.sharedController.PromoOffersPanelShouldBeShown();
			}
			if (condition)
			{
				UISprite sprite = buttons[i].GetComponent<UISprite>();
				while (sprite.alpha < 1f)
				{
					sprite.alpha += 0.04f;
					yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(buttonAlphaTime / 25f));
				}
				shines[i].SetActive(true);
				yield return new WaitForSeconds(timeBetweenShineAndTip);
				tips[i].SetActive(true);
				float startTm = Time.realtimeSinceStartup;
				_tapped = false;
				while (Time.realtimeSinceStartup - startTm < timeTipShown && !_tapped)
				{
					yield return null;
				}
				_tapped = false;
				tips[i].SetActive(false);
				shines[i].SetActive(false);
			}
		}
		Storager.setInt(Defs.ShownLobbyLevelSN, Storager.getInt(Defs.ShownLobbyLevelSN, false) + 1, false);
		yield return null;
		Object.Destroy(base.gameObject);
	}
}
