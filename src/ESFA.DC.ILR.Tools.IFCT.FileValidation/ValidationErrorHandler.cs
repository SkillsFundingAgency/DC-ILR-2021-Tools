using System;
using System.Xml;
using System.Xml.Schema;
using ESFA.DC.ILR.Tools.IFCT.FileValidation.Interfaces;
using ESFA.DC.Logging.Interfaces;

namespace ESFA.DC.ILR.Tools.IFCT.FileValidation
{
    public class ValidationErrorHandler : IValidationErrorHandler
    {
        private readonly ILogger _logger;

        public ValidationErrorHandler(ILogger logger)
        {
            _logger = logger;
        }

        public void XsdNsValidationErrorHandler(object sender, ValidationEventArgs e)
        {
            if (e.Severity == XmlSeverityType.Warning)
            {
                if (sender is IXmlLineInfo xmlMessageInfo)
                {
                    Console.WriteLine("Supplied XML does not conform to the XSD, see Validation Errors for Detailed Results.");
                    _logger.LogError(e.Message, e.Exception, callerLineNumber: xmlMessageInfo.LineNumber);
                }
            }
        }

        public void XsdValidationErrorHandler(object sender, ValidationEventArgs e)
        {
            if (sender is IXmlLineInfo xmlLineInfo)
            {
                Console.WriteLine("Supplied XML does not conform to the XSD, see Validation Errors for Detailed Results.");
                _logger.LogError(e.Message, e.Exception, callerLineNumber: xmlLineInfo.LineNumber);
            }
        }
    }
}
