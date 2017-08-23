using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TraningPortal.Startup))]
namespace TraningPortal
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
