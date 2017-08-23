using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TraningPortal.Models
{
    public class PracticeStudent
    {
        public int Id { get; set; }

        public virtual ICollection<Course> Course { get; set; }

        public virtual ICollection<ApplicationUser> User { get; set; }
    }
}