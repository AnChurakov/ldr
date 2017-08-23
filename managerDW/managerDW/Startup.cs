using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(managerDW.Startup))]
namespace managerDW
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
