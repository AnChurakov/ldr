namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpTask : DbMigration
    {
        public override void Up()
        {
            RenameTable(name: "dbo.StatusWorkTasks", newName: "TasksStatusWorks");
            DropForeignKey("dbo.TasksInfoProjects", "Tasks_Id", "dbo.Tasks");
            DropForeignKey("dbo.TasksInfoProjects", "InfoProject_Id", "dbo.InfoProjects");
            DropIndex("dbo.TasksInfoProjects", new[] { "Tasks_Id" });
            DropIndex("dbo.TasksInfoProjects", new[] { "InfoProject_Id" });
            DropPrimaryKey("dbo.TasksStatusWorks");
            AddColumn("dbo.Tasks", "InfoProjects_Id", c => c.Guid());
            AddPrimaryKey("dbo.TasksStatusWorks", new[] { "Tasks_Id", "StatusWork_Id" });
            CreateIndex("dbo.Tasks", "InfoProjects_Id");
            AddForeignKey("dbo.Tasks", "InfoProjects_Id", "dbo.InfoProjects", "Id");
            DropTable("dbo.TasksInfoProjects");
        }
        
        public override void Down()
        {
            CreateTable(
                "dbo.TasksInfoProjects",
                c => new
                    {
                        Tasks_Id = c.Guid(nullable: false),
                        InfoProject_Id = c.Guid(nullable: false),
                    })
                .PrimaryKey(t => new { t.Tasks_Id, t.InfoProject_Id });
            
            DropForeignKey("dbo.Tasks", "InfoProjects_Id", "dbo.InfoProjects");
            DropIndex("dbo.Tasks", new[] { "InfoProjects_Id" });
            DropPrimaryKey("dbo.TasksStatusWorks");
            DropColumn("dbo.Tasks", "InfoProjects_Id");
            AddPrimaryKey("dbo.TasksStatusWorks", new[] { "StatusWork_Id", "Tasks_Id" });
            CreateIndex("dbo.TasksInfoProjects", "InfoProject_Id");
            CreateIndex("dbo.TasksInfoProjects", "Tasks_Id");
            AddForeignKey("dbo.TasksInfoProjects", "InfoProject_Id", "dbo.InfoProjects", "Id", cascadeDelete: true);
            AddForeignKey("dbo.TasksInfoProjects", "Tasks_Id", "dbo.Tasks", "Id", cascadeDelete: true);
            RenameTable(name: "dbo.TasksStatusWorks", newName: "StatusWorkTasks");
        }
    }
}
