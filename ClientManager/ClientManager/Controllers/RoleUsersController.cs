using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientManager.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity.EntityFramework;

namespace ClientManager.Controllers
{
    public class RoleUsersController : Controller
    {
        // GET: RoleUsers
        [Authorize]
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var Roles = dbContext.Roles.ToList();
            return View(Roles);
        }

        [Authorize]
        public ActionResult SetRoleUser()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            RoleViewModel roles = new RoleViewModel {

                Role = dbContext.Roles.ToList(),
                Users = dbContext.Users.ToList()

            };

            return View(roles);
        }

        [HttpPost]
        [Authorize]
        public RedirectResult AddRoleUser(string User, string Role)
        {

            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectUser = dbContext.Users.FirstOrDefault(a => a.Id == User);
            var SelectRole = dbContext.Roles.FirstOrDefault(s => s.Id == Role);

            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(dbContext));
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(dbContext));

            if (User != null && Role != null)
            {
                userManager.AddToRole(SelectUser.Id, SelectRole.Name);
            }

            return Redirect("~/RoleUsers/SetRoleUser");
        }

        [HttpPost]
        [Authorize]
        public RedirectResult AddRole(string NameRole)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            if (NameRole != null)
            {
                var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(dbContext));

                var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(dbContext));

                var role = new IdentityRole { Name = NameRole };

                roleManager.Create(role);
                dbContext.SaveChanges();
            }


            return Redirect("~/RoleUsers/Index");
        }
    }
}