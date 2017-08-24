using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using ClientManager.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace ClientManager.Controllers
{
    public class AdminManagerController : Controller
    {
        // GET: AdminManagert
        [Authorize]
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var ListProjects = dbContext.InfoProjects.ToList();
            
            return View(ListProjects);
        }

        [HttpPost]
        public RedirectToRouteResult AddUser(string NameUser, string PasswordUser)
        {
           
            ApplicationDbContext dbContext = new ApplicationDbContext();
            
            if (NameUser != null && PasswordUser != null)
            {
                ApplicationUser user = new ApplicationUser {

                    UserName = NameUser,
                    Email = NameUser,
                    
                };

                IdentityResult result = UserManager.Create(user, PasswordUser);

                
            }
           

            return RedirectToAction("Index", "AdminManager");
        }


        private ApplicationUserManager UserManager
        {
           get
            {
                return HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
        }

    }
}