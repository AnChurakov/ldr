using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using TraningPortal.Models;

namespace TraningPortal.Controllers
{
    public class CourseController : Controller
    {
        // GET: Course
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var ListCourse = dbContext.Courses.ToListAsync().Result;

            return View(ListCourse);
        }

        public string RegUserCourse(int IdCourse)
        {
            
            
            return "";
        }
    }
}