using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using ClientManager.Models;

namespace ClientManager.Controllers
{
    public class ProjectController : Controller
    {
        [Authorize]
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var Projects = dbContext.InfoProjects.ToList();

            return View(Projects);
        }

        [Authorize]
        public ActionResult SelectProject(Guid Id)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var Select = dbContext.InfoProjects.FirstOrDefault(a => a.Id == Id);

                ViewBag.NameProject = Select.Name;
                ViewBag.Desc = Select.Description;
            
           
            return View(Select);
        }

        [Authorize]
        public ActionResult AddProject()
        {

            return View();
        }

        [Authorize]
        [HttpPost]
        public RedirectResult Add(string NameProject, string DescProject, string LinkProject)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            if (NameProject != null && DescProject != null && LinkProject != null)
            {
                InfoProject project = new InfoProject {

                    Id = Guid.NewGuid(),
                    Name = NameProject,
                    Description = DescProject,
                    LinkSubdomen = LinkProject

                };

                dbContext.InfoProjects.Add(project);
                dbContext.SaveChanges();
            }

            return Redirect("~/AdminManager/Index");
        }

    }
}