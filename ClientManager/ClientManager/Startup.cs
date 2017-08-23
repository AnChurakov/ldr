using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ClientManager.Startup))]
namespace ClientManager
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
