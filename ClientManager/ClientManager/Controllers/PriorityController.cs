using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientManager.Models;

namespace ClientManager.Controllers
{
    public class PriorityController : Controller
    {
        // GET: Priority
        [Authorize]
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var ListPrior = dbContext.Prioritys.ToList();

            return View(ListPrior);
        }
    }
}