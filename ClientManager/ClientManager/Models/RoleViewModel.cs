using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClientManager.Models;
using Microsoft.AspNet.Identity.EntityFramework;

namespace ClientManager.Models
{
    public class RoleViewModel
    {
        public virtual IEnumerable<ApplicationUser> Users { get; set;}
        public virtual IEnumerable<IdentityRole> Role { get; set; }
    }
}