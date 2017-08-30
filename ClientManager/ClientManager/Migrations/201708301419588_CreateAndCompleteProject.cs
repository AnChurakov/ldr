namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CreateAndCompleteProject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.InfoProjects", "Create", c => c.DateTime(nullable: false));
            AddColumn("dbo.InfoProjects", "Completed", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.InfoProjects", "Completed");
            DropColumn("dbo.InfoProjects", "Create");
        }
    }
}
