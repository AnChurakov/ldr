using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using ClientManager.Models;

namespace ClientManager.Models
{
    public class TaskViewModel
    {
        public IEnumerable<Tasks> Tasks { get; set; }
        public IEnumerable<InfoProject> Projects { get; set; }
        public IEnumerable<StatusWork> StatusWorks { get; set; }
        public IEnumerable<Priority> Prioritys { get; set; }
    }
}