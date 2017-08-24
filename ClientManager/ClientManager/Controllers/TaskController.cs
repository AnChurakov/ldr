using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ClientManager.Controllers
{
    public class TaskController : Controller
    {
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }
    }
}