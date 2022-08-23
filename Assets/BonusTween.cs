using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class BonusTween : MonoBehaviour {

	double time = 0;

	void Update () {
		time += Time.deltaTime;
		transform.localScale = new Vector3((float)(1+Math.Sin(time*2)/2), (float)(1+Math.Sin(time*2)/2), 1);
	}
}
