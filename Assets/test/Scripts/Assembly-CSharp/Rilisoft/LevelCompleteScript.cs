using UnityEngine;

namespace Rilisoft
{
	public class LevelCompleteScript : MonoBehaviour
	{
		public UILabel[] afterLevelAwardLabels;
		public Transform RentWindowPoint;
		public UILabel[] awardBoxLabels;
		public GameObject mainPanel;
		public GameObject loadingPanel;
		public GameObject quitButton;
		public GameObject menuButton;
		public GameObject retryButton;
		public GameObject nextButton;
		public GameObject shopButton;
		public GameObject brightStarPrototypeSprite;
		public GameObject darkStarPrototypeSprite;
		public GameObject award1coinSprite;
		public GameObject award15coinsSprite;
		public GameObject checkboxSpritePrototype;
		public AudioClip[] coinClips;
		public AudioClip[] starClips;
		public AudioClip shopButtonSound;
		public AudioClip awardClip;
		public GameObject survivalResults;
		public GameObject backgroundTexture;
		public GameObject backgroundSurvivalTexture;
		public GameObject[] statisticLabels;
		public GameObject gameOverSprite;
		public UICamera uiCamera;
	}
}
