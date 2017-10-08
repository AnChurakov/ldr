using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClientManager.Models;

namespace ClientManager.Models
{
    public class InfoProject
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string LinkSubdomen { get; set; }

        public ApplicationUser Users { get; set; }

        public DateTime Create { get; set; }

        public DateTime Completed { get; set; }

        public StatusWork StatusWorks { get; set; }

        public int Progress { get; set; }

        public virtual ICollection<Tasks> Tasks { get; set; }
    }
}