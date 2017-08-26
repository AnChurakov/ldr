using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientManager.Models;

namespace ClientManager.Controllers
{
    public class StatusWorkController : Controller
    {
        // GET: StatusWork
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Authorize]
        public RedirectResult AddStatus(string NameStatus)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            if (NameStatus != null)
            {
                StatusWork work = new StatusWork
                {
                    Id = Guid.NewGuid(),
                    Name = NameStatus
                };

                dbContext.StatusWorks.Add(work);
                dbContext.SaveChanges();
            }

            return Redirect("~/StatusWork/Index");
        }
    }
}