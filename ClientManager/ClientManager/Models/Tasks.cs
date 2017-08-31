using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClientManager.Models;

namespace ClientManager.Models
{
    public class Tasks
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public Priority Prioritys { get; set; }
        public virtual ICollection<StatusWork> StatusWorks { get; set; }
        public virtual ICollection<InfoProject> InfoProjects { get; set; }
    }
}