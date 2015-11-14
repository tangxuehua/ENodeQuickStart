using System.Configuration;

namespace NoteSample.Common
{
    public class ConfigSettings
    {
        public static string ConnectionString { get; set; }

        public static void Initialize()
        {
            ConnectionString = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
        }
    }
}
