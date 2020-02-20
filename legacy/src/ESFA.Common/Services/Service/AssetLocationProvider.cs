using ESFA.Common.Service;
using System;
using System.Composition;
using System.IO;

namespace ESFA.Common.Abstract
{
    [Export(typeof(IProvideAssetLocation))]
    public sealed class AssetLocationProvider :
        IProvideAssetLocation
    {
        /// <summary>
        /// Gets the asset location.
        /// </summary>
        public string OfAssets { get; } = Path.Combine(AppContext.BaseDirectory, "Assets");
    }
}
