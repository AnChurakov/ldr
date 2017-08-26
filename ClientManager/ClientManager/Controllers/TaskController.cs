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
                StatusWorks = dbContext.StatusWorks.ToList()

            };

            return View(TaskAndProject);
        }

        [Authorize]
        [HttpPost]
        public RedirectResult AddTask(Guid SelectProject, string NameTask, Guid SelectStatus)
        {
            ApplicationDbContext dbContext = new ApplicationDbContext();

            var SelectProj = dbContext.InfoProjects.FirstOrDefault(a => a.Id == SelectProject);
            var SelectStat = dbContext.StatusWorks.FirstOrDefault(s => s.Id == SelectStatus);

            if (NameTask != null)
            {
                Tasks task = new Tasks
                {
                    Id = Guid.NewGuid(),
                    Name = NameTask,
                    Description = null,
                    InfoProjects = new List<InfoProject>() { SelectProj},
                    StatusWorks = new List<StatusWork>() { SelectStat} 

                };

                dbContext.Tasks.Add(task);
                dbContext.SaveChanges();
            }

            return Redirect("~/Task/Index");
        }
    }
}