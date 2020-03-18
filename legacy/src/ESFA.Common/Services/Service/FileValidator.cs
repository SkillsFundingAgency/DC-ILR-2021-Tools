using ESFA.Common.Set;
using ESFA.Common.Model;
using ESFA.Common.Utility;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Schema;
using Tiny.Framework.Utilities;

namespace ESFA.Common.Service
{
    /// <summary>
    /// the file conversion manager
    /// </summary>
    /// <seealso cref="IValidateXMLFiles" />
    [Shared]
    [Export(typeof(IValidateXMLFiles))]
    public sealed class FileValidator :
            IValidateXMLFiles
    {
        /// <summary>
        /// Gets or sets the (console) emitter.
        /// </summary>
        [Import]
        public IEmitToConsole Emitter { get; set; }

        /// <summary>
        /// Validates...
        /// </summary>
        /// <param name="thisFile">this file.</param>
        /// <param name="againstThisSchema">against this schema.</param>
        public async Task<bool> IsValid(string thisFile, string againstThisSchema)
        {
            return await Task.Run(() =>
            {
                var errors = Collection.Empty<IDetailXmlValidationError>();

                Emitter.Publish(Localised.PerformingSchemaValidationOnFormat, thisFile);
                Emitter.Publish(Indentation.FirstLevel, Localised.UsingSchemaFileFormat, againstThisSchema);

                var settings = GetSettings(againstThisSchema, errors);

                Validate(thisFile, settings);

                if (!errors.Any())
                {
                    Emitter.Publish(Indentation.FirstLevel, CommonLocalised.Completed);
                    return true;
                }

                Emitter.Publish(Indentation.FirstLevel, Localised.ValidationFailedDueToErrors);
                errors.ForEach(x => Emitter.Publish(Indentation.FirstLevel, Localised.ValidationFailedFormat, x.Count, x.Message));
                return false;
            });
        }

        /// <summary>
        /// Gets the settings.
        /// </summary>
        /// <param name="schemaFile">The schema file.</param>
        /// <param name="errors">The error collection for the validation handler.</param>
        /// <returns>the reader settings</returns>
        public XmlReaderSettings GetSettings(string schemaFile, ICollection<IDetailXmlValidationError> errors)
        {
            var settings = new XmlReaderSettings()
            {
                ValidationType = ValidationType.Schema
            };

            settings.ValidationFlags |= XmlSchemaValidationFlags.ReportValidationWarnings;
            settings.ValidationEventHandler += new ValidationEventHandler((s, e) => ValidationCallBack(s, e, errors));
            settings.Schemas.Add(null, schemaFile);

            return settings;
        }

        /// <summary>
        /// Validates the specified file.
        /// </summary>
        /// <param name="thisFile">this file.</param>
        /// <param name="usingSettings">using settings.</param>
        public void Validate(string thisFile, XmlReaderSettings usingSettings)
        {
            using (var reader = XmlReader.Create(thisFile, usingSettings))
            {
                while (reader.Read()) ;
            }
        }

        /// <summary>
        /// Validation call back.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="ValidationEventArgs"/> instance containing the event data.</param>
        private void ValidationCallBack(object sender, ValidationEventArgs e, ICollection<IDetailXmlValidationError> errors)
        {
            var error = errors.FirstOrDefault(x => Format.ComparesWith(x.Message, e.Message));

            if (It.IsNull(error))
            {
                error = new XMLErrorDetail
                {
                    Message = e.Message,
                    Count = 0
                };

                errors.Add(error);
            }

            error.IncreaseCount();
        }
    }
}