using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientManager.Models;

namespace ClientManager.Controllers
{
    public class TaskController : Controller
    {
        [Authorize]
        public ActionResult Index()
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            TaskViewModel TaskAndProject = new TaskViewModel {

                Projects = dbContext.InfoProjects.ToList(),
                Tasks = dbContext.Tasks.ToList(),
                StatusWorks = dbContext.StatusWorks.ToList(),
                Prioritys = dbContext.Prioritys.ToList()
                

            };           

            return View(TaskAndProject);
        }

        [Authorize]
        [HttpPost]
        public RedirectResult AddTask(Guid SelectProject, string NameTask, Guid SelectStatus, Guid SelectPrior)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectProj = dbContext.InfoProjects.FirstOrDefault(a => a.Id == SelectProject);
            var SelectStat = dbContext.StatusWorks.FirstOrDefault(s => s.Id == SelectStatus);
            var SelectPri = dbContext.Prioritys.FirstOrDefault(t => t.Id == SelectPrior);

            if (NameTask != null)
            {
                Tasks task = new Tasks
                {
                    Id = Guid.NewGuid(),
                    Name = NameTask,
                    Description = null,
                    InfoProjects = new List<InfoProject>() { SelectProj},
                    StatusWorks = new List<StatusWork>() { SelectStat},
                    Prioritys = SelectPri

                };

                dbContext.Tasks.Add(task);
                dbContext.SaveChanges();
            }

            return Redirect("~/Task/Index");
        }

        [Authorize]
        [HttpPost]
        public RedirectToRouteResult UpdateStatus(Guid GuidTask, Guid GuidStatus)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectProject = dbContext.Tasks.FirstOrDefault(a => a.Id == GuidTask);

            var SelectStatus = dbContext.StatusWorks.FirstOrDefault(s => s.Id == GuidStatus);

            SelectProject.StatusWorks = new List<StatusWork>() { SelectStatus};

            dbContext.SaveChanges();
            
            return RedirectToAction("SelectTask", "Task", new { Id = GuidTask});
        }

        [Authorize]
        [HttpGet]
        public RedirectToRouteResult Delete(Guid Id, Guid IdProject)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectTask = dbContext.Tasks.FirstOrDefault(a => a.Id == Id);

            var SelectProject = dbContext.InfoProjects.FirstOrDefault(t => t.Id == IdProject);

            dbContext.Tasks.Remove(SelectTask);
            dbContext.SaveChanges();

            return RedirectToAction("SelectProject", "Project", new { Id = SelectProject.Id});
        }

        [Authorize]
        public ActionResult SelectTask(Guid Id)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectTask = dbContext.Tasks.FirstOrDefault(a => a.Id == Id);

            ViewBag.Name = SelectTask.Name;
            ViewBag.Desc = SelectTask.Description;

            ViewBag.Status = dbContext.StatusWorks.ToList();

            return View(SelectTask);
        }
    }
}