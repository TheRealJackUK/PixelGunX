using Holoville.HOTween;
using UnityEngine;

public class HOTweenDemoBrain : MonoBehaviour
{
	public Transform CubeTrans1;

	public Transform CubeTrans2;

	public Transform CubeTrans3;

	public string SampleString;

	public float SampleFloat;

	private void Start()
	{
		HOTween.Init(true, true, true);
		HOTween.To(CubeTrans1, 4f, "position", new Vector3(-3f, 6f, 0f));
		HOTween.To(CubeTrans2, 3f, new TweenParms().Prop("position", new Vector3(0f, 6f, 0f), true).Prop("rotation", new Vector3(0f, 1024f, 0f), true).Loops(-1, LoopType.Yoyo)
			.Ease(EaseType.EaseInOutQuad)
			.OnStepComplete(Cube2StepComplete));
		HOTween.To(this, 3f, new TweenParms().Prop("SampleString", "Hello I'm a sample tweened string").Ease(EaseType.Linear).Loops(-1, LoopType.Yoyo));
		TweenParms p_parms = new TweenParms().Prop("SampleFloat", 27.5f).Ease(EaseType.Linear).Loops(-1, LoopType.Yoyo);
		HOTween.To(this, 3f, p_parms);
		Color color = CubeTrans3.GetComponent<Renderer>().material.color;
		color.a = 0f;
		Sequence sequence = new Sequence(new SequenceParms().Loops(-1, LoopType.Yoyo));
		sequence.Append(HOTween.To(CubeTrans3, 1f, new TweenParms().Prop("rotation", new Vector3(360f, 0f, 0f))));
		sequence.Append(HOTween.To(CubeTrans3, 1f, new TweenParms().Prop("position", new Vector3(0f, 6f, 0f), true)));
		sequence.Append(HOTween.To(CubeTrans3, 1f, new TweenParms().Prop("rotation", new Vector3(0f, 360f, 0f))));
		sequence.Insert(sequence.duration * 0.5f, HOTween.To(CubeTrans3.GetComponent<Renderer>().material, sequence.duration * 0.5f, new TweenParms().Prop("color", color)));
		sequence.Play();
	}

	private void OnGUI()
	{
		GUILayout.Label("String tween: " + SampleString);
		GUILayout.Label("Float tween: " + SampleFloat);
	}

	private void Cube2StepComplete()
	{
		Debug.Log("HOTween: Cube 2 Step Complete");
	}
}
