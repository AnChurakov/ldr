using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace managerDW.Models
{
    public class ContextDb : DbContext
    {
        public ContextDb() : base("DefaultConnection")
        { }

        public DbSet<TestModel> TestModels { get; set; }
    }
}