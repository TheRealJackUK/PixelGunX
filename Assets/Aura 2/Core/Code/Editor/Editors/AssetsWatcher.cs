
/***************************************************************************
*                                                                          *
*  Copyright (c) Raphaël Ernaelsten (@RaphErnaelsten)                      *
*  All Rights Reserved.                                                    *
*                                                                          *
*  NOTICE: Aura 2 is a commercial project.                                 * 
*  All information contained herein is, and remains the property of        *
*  Raphaël Ernaelsten.                                                     *
*  The intellectual and technical concepts contained herein are            *
*  proprietary to Raphaël Ernaelsten and are protected by copyright laws.  *
*  Dissemination of this information or reproduction of this material      *
*  is strictly forbidden.                                                  *
*                                                                          *
***************************************************************************/

using System;
using UnityEngine;
using UnityEditor;

namespace Aura2API
{
    /// <summary>
    /// Class that will raise an event if any action is performed on any asset
    /// </summary>
    public class AssetsWatcher : UnityEditor.AssetModificationProcessor
    {
        #region Events
        /// <summary>
        /// Event raised when an action is made on an asset in the project
        /// </summary>
        public static event Action OnAnyAssetModified;
        #endregion

        #region Functions 
        private static void RaiseOnAnyAssetModified()
        {
            if (OnAnyAssetModified != null)
            {
                OnAnyAssetModified();
            }
        }
        #endregion

        #region Inherited messages
        private static void OnWillCreateAsset(string path)
        {
            RaiseOnAnyAssetModified();
        }

        private static AssetDeleteResult OnWillDeleteAsset(string path, RemoveAssetOptions options)
        {
            RaiseOnAnyAssetModified();

            return AssetDeleteResult.DidNotDelete;
        }

        private static AssetMoveResult OnWillMoveAsset(string oldPath, string newpath)
        {
            RaiseOnAnyAssetModified();

            return AssetMoveResult.DidNotMove;
        }

        private static void OnWillSaveAssets(string[] paths)
        {
            RaiseOnAnyAssetModified();
        }
        #endregion
    }
}
