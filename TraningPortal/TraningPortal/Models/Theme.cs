using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace TraningPortal.Models
{
    public class Theme
    {
        public int Id { get; set; }

        public string NameTheme { get; set; }

        public Course Course { get; set; }
    }
}