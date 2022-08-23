using System;

[Serializable]
public class PhotonTransformViewRotationModel
{
	public enum InterpolateOptions
	{
		Disabled,
		RotateTowards,
		Lerp
	}

	public bool SynchronizeEnabled;

	public InterpolateOptions InterpolateOption = InterpolateOptions.RotateTowards;

	public float InterpolateRotateTowardsSpeed = 180f;

	public float InterpolateLerpSpeed = 5f;
}
