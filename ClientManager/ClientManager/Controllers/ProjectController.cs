using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using ClientManager.Models;
using PagedList;
using PagedList.Mvc;

namespace ClientManager.Controllers
{
    public class ProjectController : Controller
    {
        [Authorize]
        public ActionResult Index(int? page)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var Projects = dbContext.InfoProjects.ToList();

            int pageSize = 3;
            int pageNumber = (page ?? 1);

            return View(Projects.ToPagedList(pageNumber, pageSize));
        }

        [Authorize]
        public ActionResult SelectProject(Guid Id)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var Select = dbContext.InfoProjects.FirstOrDefault(a => a.Id == Id);


                ViewBag.NameProject = Select.Name;
                ViewBag.Desc = Select.Description;
                ViewBag.Progress = Select.Progress;

          
            return View(Select);
        }

        [Authorize]
        public ActionResult AddProject()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var ListUsers = dbContext.Users.ToList();

            return View(ListUsers);
        }

        [Authorize]
        [HttpPost]
        public RedirectToRouteResult Update(int Procent, Guid GuidProject)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectProject = dbContext.InfoProjects.FirstOrDefault(a => a.Id == GuidProject);

            if (GuidProject != null && Procent <= 100)
            {
                SelectProject.Progress = Procent;
                dbContext.SaveChanges();
            }

            return RedirectToAction("SelectProject", "Project", new { Id = GuidProject });
        }


        [Authorize]
        [HttpPost]
        public RedirectResult Add(string NameProject, string DescProject, string LinkProject, string User, int Progress)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var UserId = dbContext.Users.FirstOrDefault(a => a.Id == User);

            if (NameProject != null && DescProject != null && LinkProject != null && UserId != null && Progress != null)
            {
                InfoProject project = new InfoProject {

                    Id = Guid.NewGuid(),
                    Name = NameProject,
                    Description = DescProject,
                    LinkSubdomen = LinkProject,
                    Users = UserId,
                    Create = DateTime.Now,
                    Progress = Progress
                    

                };

                dbContext.InfoProjects.Add(project);
                dbContext.SaveChanges();
            }

            return Redirect("~/AdminManager/Index");
        }

    }
}