using System;
using System.Reflection;
using ECommon.Autofac;
using ECommon.Components;
using ECommon.Configurations;
using ECommon.JsonNet;
using ECommon.Log4Net;
using ECommon.Logging;
using ECommon.Utilities;
using ENode.Commanding;
using ENode.Configurations;
using NoteSample.Commands;
using NoteSample.Common;

namespace NoteSample.ConsoleApp
{
    class Program
    {
        static ILogger _logger;
        static ENodeConfiguration _configuration;

        static void Main(string[] args)
        {
            ConfigSettings.Initialize();
            InitializeENodeFramework();

            var commandService = ObjectContainer.Resolve<ICommandService>();

            var noteId = ObjectId.GenerateNewStringId();
            var command1 = new CreateNoteCommand { AggregateRootId = noteId, Title = "Sample Title1" };
            var command2 = new ChangeNoteTitleCommand { AggregateRootId = noteId, Title = "Sample Title2" };

            Console.WriteLine(string.Empty);

            _logger.Info("Creating Note...");
            commandService.ExecuteAsync(command1, CommandReturnType.EventHandled).Wait();
            _logger.Info("Note create success.");

            Console.WriteLine(string.Empty);

            _logger.Info("Updating Note");
            commandService.ExecuteAsync(command2, CommandReturnType.EventHandled).Wait();
            _logger.Info("Note update success.");

            Console.WriteLine(string.Empty);

            _logger.Info("Press Enter to exit...");

            Console.ReadLine();
            _configuration.ShutdownEQueue();
        }

        static void InitializeENodeFramework()
        {
            var assemblies = new[]
            {
                Assembly.Load("NoteSample.Domain"),
                Assembly.Load("NoteSample.Commands"),
                Assembly.Load("NoteSample.CommandHandlers"),
                Assembly.Load("NoteSample.Denormalizers"),
                Assembly.GetExecutingAssembly()
            };
            var setting = new ConfigurationSetting
            {
                SqlDefaultConnectionString = ConfigSettings.ConnectionString
            };

            _configuration = Configuration
                .Create()
                .UseAutofac()
                .RegisterCommonComponents()
                .UseLog4Net()
                .UseJsonNet()
                .RegisterUnhandledExceptionHandler()
                .CreateENode(setting)
                .RegisterENodeComponents()
                .RegisterBusinessComponents(assemblies)
                .UseSqlServerCommandStore()
                .UseSqlServerEventStore()
                .UseSqlServerSequenceMessagePublishedVersionStore()
                .UseSqlServerMessageHandleRecordStore()
                .UseEQueue()
                .InitializeBusinessAssemblies(assemblies)
                .StartEQueue();

            Console.WriteLine(string.Empty);

            _logger = ObjectContainer.Resolve<ILoggerFactory>().Create(typeof(Program).Name);
            _logger.Info("ENode started...");
        }
    }
}
