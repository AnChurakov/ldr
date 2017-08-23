using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using TraningPortal.Models;

namespace TraningPortal.Models
{
    public class Course
    {
        public int Id { get; set; }

        public string NameCourse { get; set; }

        public virtual ApplicationUser Trainer { get; set; }

        public virtual ICollection<ApplicationUser> User { get; set; }
    }
}