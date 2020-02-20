using EasyOPA.Abstract;
using EasyOPA.Model;
using EasyOPA.Set;
using EasyOPA.Utility;
using System;
using System.Composition;
using System.IO;
using Tiny.Framework.Contracts.Message;
using Tiny.Framework.Utilities;

namespace EasyOPA.Provider
{
    /// <summary>
    /// pseudonym configuration host
    /// </summary>
    /// <seealso cref="FileConfigurationHostBase{TokenSubstitutionMap, IMapTokenSubstitutions}" />
    /// <seealso cref="IProvideTokenSubstitution" />
    [Shared]
    [Export(typeof(IProvideTokenSubstitution))]
    public sealed class TokenSubstitutionProvider :
        SpecialisedFileConfigurationHostBase<TokenSubstitutionMap, IMapTokenSubstitutions>,
        IHandleMessage<IChangeOperatingYearMessage>,
        IProvideTokenSubstitution
    {
        /// <summary>
        /// The operating year
        /// </summary>
        private BatchOperatingYear _operatingYear;

        /// <summary>
        /// Gets the specialised asset location.
        /// </summary>
        private string _specialisedAssetLocation => Path.Combine(Location.OfAssets, _operatingYear.AsString());

        /// <summary>
        /// Gets the candidate location.
        /// </summary>
        private string _candidateLocation => Path.Combine(_specialisedAssetLocation, Asset.Locations.Experimental);

        /// <summary>
        /// The configuration filename
        /// </summary>
        protected override string ConfigurationFilename => Asset.GetRunMode().TokenMap; //"tokensubstitutionmap.cfg";

        /// <summary>
        /// Gets the load path.
        /// </summary>
        /// <returns>
        /// the path to the configuration file
        /// </returns>
        public override string GetLoadPath()
        {
            return UseExperimental && CanUseExperimental()
                ? Path.Combine(_candidateLocation, ConfigurationFilename)
                : Path.Combine(_specialisedAssetLocation, ConfigurationFilename);
        }

        public bool CanUseExperimental()
        {
            return File.Exists(Path.Combine(_candidateLocation, ConfigurationFilename));
        }

        /// <summary>
        /// Performs the health check.
        /// </summary>
        public override void PerformHealthCheck()
        {
            Configured.Substitutions.ForEach(x =>
            {
                It.IsEmpty(x.TokenValue)
                    .AsGuard<ArgumentException>($"no substitution can have an empty {nameof(x.TokenValue)}");
                It.IsEmpty(x.TokenValue)
                    .AsGuard<ArgumentException>($"no substitution can have an empty {nameof(x.Substitute)}");
            });
        }

        /// <summary>
        /// Replaces the tokens in...
        /// </summary>
        /// <param name="thisContent">this Content</param>
        /// <param name="withSecondaryPass">with secondary pass.</param>
        /// <returns>
        /// detokenised content
        /// </returns>
        public string ReplaceTokensIn(string thisContent, Func<string, string> withSecondaryPass)
        {
            var detokened = thisContent;

            Configured.Substitutions.ForEach(x =>
            {
                detokened = detokened
                    .Replace(x.TokenValue, x.Substitute);
            });

            detokened = withSecondaryPass?.Invoke(detokened) ?? detokened;

            var failedReplace = detokened.Contains("${") || detokened.Contains("$(");
            failedReplace
                .AsGuard<ArgumentException>("failed to replace all the tokens");

            return detokened;
        }

        /// <summary>
        /// Supplmental load.
        /// Once the intial load is conducted and a health check
        /// performed, we can do some supplemental stuff...
        /// </summary>
        /// <param name="onConcretion">on concretion.</param>
        public override void PerformSupplmentalLoad(TokenSubstitutionMap onConcretion)
        {
            // nothing to do, here...
            // a standard load is performed after changing the file path
        }

        /// <summary>
        /// Registers the message handler.
        /// </summary>
        public override void RegisterMessageHandler()
        {
            base.RegisterMessageHandler();
            Mediator.Register<IChangeOperatingYearMessage>(HandleMessage);
        }

        /// <summary>
        /// Handles the message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void HandleMessage(IChangeOperatingYearMessage message)
        {
            _operatingYear = message.Payload.Year;
            Configure();
        }

        /// <summary>
        /// Changes the run mode.
        /// </summary>
        public override void ChangeRunMode()
        {
            if (_operatingYear != BatchOperatingYear.NotSet)
            {
                Configure();
            }
        }
    }
}
