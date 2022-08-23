using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DarkMallController : MonoBehaviour {
	public GameObject[] lights;
	public float blackoutTime;
	public float blackoutDuration;
	public bool inBlackout = false;

	public IEnumerator OnBlackoutOver(){
		inBlackout = false;
		foreach(GameObject light in lights){
			light.SetActive(true);
			yield return new WaitForSeconds(0.2f);
		}
		yield return new WaitForSeconds(blackoutTime);
		foreach(GameObject light in lights){
			light.SetActive(false);
			yield return new WaitForSeconds(0.2f);
		}
		inBlackout = true;
		yield return new WaitForSeconds(blackoutDuration);
		StartCoroutine(OnBlackoutOver());
	}

	public void Start() {
		foreach(GameObject light in lights){
			light.SetActive(true);
		}
		inBlackout = false;
		StartCoroutine(OnBlackoutOver());
	}
}
