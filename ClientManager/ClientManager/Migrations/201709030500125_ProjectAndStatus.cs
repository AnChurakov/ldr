namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ProjectAndStatus : DbMigration
    {
        public override void Up()
        {
            RenameTable(name: "dbo.StatusWorkTasks", newName: "TasksStatusWorks");
            DropPrimaryKey("dbo.TasksStatusWorks");
            AddColumn("dbo.InfoProjects", "StatusWorks_Id", c => c.Guid());
            AddPrimaryKey("dbo.TasksStatusWorks", new[] { "Tasks_Id", "StatusWork_Id" });
            CreateIndex("dbo.InfoProjects", "StatusWorks_Id");
            AddForeignKey("dbo.InfoProjects", "StatusWorks_Id", "dbo.StatusWorks", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.InfoProjects", "StatusWorks_Id", "dbo.StatusWorks");
            DropIndex("dbo.InfoProjects", new[] { "StatusWorks_Id" });
            DropPrimaryKey("dbo.TasksStatusWorks");
            DropColumn("dbo.InfoProjects", "StatusWorks_Id");
            AddPrimaryKey("dbo.TasksStatusWorks", new[] { "StatusWork_Id", "Tasks_Id" });
            RenameTable(name: "dbo.TasksStatusWorks", newName: "StatusWorkTasks");
        }
    }
}
