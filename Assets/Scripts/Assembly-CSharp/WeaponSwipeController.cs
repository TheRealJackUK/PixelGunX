using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public sealed class WeaponSwipeController : MonoBehaviour
{
	private UIWrapContent _wrapContent;

	private UIScrollView _scrollView;

	private Player_move_c move;

	private MyCenterOnChild _center;

	private bool isTraining;

	private bool _disabled;

	private void Awake()
	{
		isTraining = Defs.IsTraining;
	}

	private void Start()
	{
		_wrapContent = GetComponentInChildren<UIWrapContent>();
		_center = GetComponentInChildren<MyCenterOnChild>();
		_scrollView = GetComponent<UIScrollView>();
		MyCenterOnChild center = _center;
		center.onFinished = (SpringPanel.OnFinished)Delegate.Combine(center.onFinished, new SpringPanel.OnFinished(HandleCenteringFinished));
		UpdateContent();
	}

	private void HandleWeaponEquipped()
	{
		UpdateContent();
	}

	private void OnEnable()
	{
		StartCoroutine(_DisableSwiping(0.5f));
	}

	private IEnumerator _DisableSwiping(float tm)
	{
		int bef;
		if (_center == null || !int.TryParse(_center.centeredObject.name.Replace("preview_", string.Empty), out bef))
		{
			yield break;
		}
		_disabled = true;
		yield return new WaitForSeconds(tm);
		_disabled = false;
		if (_center.centeredObject.name.Equals("preview_" + bef))
		{
			yield break;
		}
		Transform goToCent = null;
		foreach (Transform t in _center.transform)
		{
			if (t.gameObject.name.Equals("preview_" + bef))
			{
				goToCent = t;
				break;
			}
		}
		if (goToCent != null)
		{
			_center.CenterOn(goToCent);
		}
	}

	private void HandleCenteringFinished()
	{
		if (_disabled)
		{
			return;
		}
		int result;
		if (!int.TryParse(_center.centeredObject.name.Replace("preview_", string.Empty), out result))
		{
			if (Debug.isDebugBuild)
			{
				Debug.Log("HandleCenteringFinished: error parse");
			}
			return;
		}
		result--;
		if (!move)
		{
			if (!Defs.isMulti)
			{
				move = GameObject.FindGameObjectWithTag("Player").GetComponent<SkinName>().playerMoveC;
			}
			else
			{
				move = WeaponManager.sharedManager.myPlayerMoveC;
			}
		}
		if (result != WeaponManager.sharedManager.CurrentWeaponIndex)
		{
			TrainingState value;
			if (isTraining && TrainingController.stepTrainingList.TryGetValue("SwipeWeapon", out value) && TrainingController.stepTraining == value)
			{
				TrainingController.isNextStep = TrainingController.stepTrainingList["SwipeWeapon"];
			}
			WeaponManager.sharedManager.CurrentWeaponIndex = result % WeaponManager.sharedManager.playerWeapons.Count;
			if (move != null)
			{
				move.ChangeWeapon(WeaponManager.sharedManager.CurrentWeaponIndex, false);
			}
		}
	}

	private void OnDestroy()
	{
		MyCenterOnChild center = _center;
		center.onFinished = (SpringPanel.OnFinished)Delegate.Remove(center.onFinished, new SpringPanel.OnFinished(HandleCenteringFinished));
	}

	public void UpdateContent()
	{
		List<string> list = new List<string>();
		foreach (Weapon playerWeapon in WeaponManager.sharedManager.playerWeapons)
		{
			list.Add(playerWeapon.weaponPrefab.name + "_InGamePreview");
		}
		UITexture[] componentsInChildren = GetComponentsInChildren<UITexture>();
		List<Texture> list2 = new List<Texture>();
		UITexture[] array = componentsInChildren;
		foreach (UITexture uITexture in array)
		{
			if ((bool)uITexture.mainTexture)
			{
				list2.Add(uITexture.mainTexture);
			}
		}
		List<string> list3 = new List<string>();
		foreach (string item in list)
		{
			bool flag = false;
			foreach (Texture item2 in list2)
			{
				if (item2.name.Equals(item))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				list3.Add(item);
			}
		}
		foreach (string item3 in list3)
		{
			Texture texture = Resources.Load(WeaponManager.WeaponPreviewsPath + "/" + item3) as Texture;
			texture.name = item3;
			if (texture != null)
			{
				list2.Add(texture);
			}
		}
		Transform child = base.transform.GetChild(0);
		int childCount = child.childCount;
		if (childCount > list.Count)
		{
			for (int j = list.Count; j < childCount; j++)
			{
				Transform child2 = child.GetChild(j);
				child2.parent = null;
				UnityEngine.Object.Destroy(child2.gameObject);
			}
		}
		else if (childCount < list.Count)
		{
			for (int k = childCount; k < list.Count; k++)
			{
				if (k >= childCount)
				{
					GameObject original = Resources.Load("WeaponPreviewPrefab") as GameObject;
					GameObject gameObject = UnityEngine.Object.Instantiate(original) as GameObject;
					gameObject.transform.parent = child;
					gameObject.name = "preview_" + (k + 1);
					gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
				}
			}
		}
		for (int l = 0; l < list.Count; l++)
		{
			Transform child3 = child.GetChild(l);
			if (!child3)
			{
				continue;
			}
			foreach (Texture item4 in list2)
			{
				if (item4.name.Equals(list[l]))
				{
					child3.GetComponent<UITexture>().mainTexture = item4;
					break;
				}
			}
		}
		_wrapContent.SortAlphabetically();
		Transform target = _center.transform.GetChild(0);
		foreach (Transform item5 in _wrapContent.transform)
		{
			if (item5.gameObject.name.Equals("preview_" + (WeaponManager.sharedManager.CurrentWeaponIndex + 1)))
			{
				target = item5;
				break;
			}
		}
		_center.CenterOn(target);
	}
}
