using ESFA.DC.FileService.Interface;
using ESFA.DC.ILR.Tools.IFCT.Service.Interface;
using ESFA.DC.Serialization.Interfaces;
using System;
using System.Diagnostics;
using System.Threading.Tasks;
using ILogger = ESFA.DC.Logging.Interfaces.ILogger;

namespace ESFA.DC.ILR.Tools.IFCT.Service
{
    public class AnnualMapper : IAnnualMapper
    {
        private readonly IFileService _fileService;
        private readonly IXmlSerializationService _xmlSerializationService;
        private readonly IMap<Loose.Previous.Message, Loose.Message> _mapper;
        private readonly ILogger _logger;

        public AnnualMapper(
            IFileService fileService, 
            IXmlSerializationService xmlSerializationService, 
            IMap<Loose.Previous.Message, Loose.Message> mapper,
            ILogger logger)
        {
            _fileService = fileService;
            _xmlSerializationService = xmlSerializationService;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<bool> MapFileAsync(string source, string target)
        {
            _logger.LogInfo($"Mappiing {source} to {target}");

            var timer = new Stopwatch();
            timer.Start();

            try
            {
                var sourceStream = await _fileService.OpenReadStreamAsync(source, null, new System.Threading.CancellationToken());
                _logger.LogVerbose($"Read in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                var sourceMessage = _xmlSerializationService.Deserialize<Loose.Previous.Message>(sourceStream);
                _logger.LogVerbose($"Deserialize in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                var targetMessage = _mapper.Map(sourceMessage);
                _logger.LogVerbose($"Mapped in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                var targetStream = await _fileService.OpenWriteStreamAsync(target, null, new System.Threading.CancellationToken());
                _logger.LogVerbose($"Get Out Stream in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                _xmlSerializationService.Serialize<Loose.Message>(targetMessage, targetStream);
                _logger.LogVerbose($"Serialize in {timer.ElapsedMilliseconds}ms");
                timer.Restart();

                await targetStream.FlushAsync();
                _logger.LogVerbose($"Flush in {timer.ElapsedMilliseconds}ms");
                timer.Restart();
            }
            catch (Exception ex)
            {
                _logger.LogFatal($"Failed mappiing {source} to {target}", ex);
                return false;
            }

            return true;
        }
    }
}
