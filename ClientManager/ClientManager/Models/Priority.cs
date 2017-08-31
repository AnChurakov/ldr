using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClientManager.Models;

namespace ClientManager.Models
{
    public class Priority
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<Tasks> Tasks { get; set; }

    }
}