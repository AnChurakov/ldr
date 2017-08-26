using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ClientManager.Models
{
    public class InfoProject
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string LinkSubdomen { get; set; }

        public virtual ICollection<Tasks> Tasks { get; set; }
    }
}