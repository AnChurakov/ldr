namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InfoProjAndTask : DbMigration
    {
        public override void Up()
        {
            RenameTable(name: "dbo.TasksStatusWorks", newName: "StatusWorkTasks");
            DropPrimaryKey("dbo.StatusWorkTasks");
            CreateTable(
                "dbo.TasksInfoProjects",
                c => new
                    {
                        Tasks_Id = c.Guid(nullable: false),
                        InfoProject_Id = c.Guid(nullable: false),
                    })
                .PrimaryKey(t => new { t.Tasks_Id, t.InfoProject_Id })
                .ForeignKey("dbo.Tasks", t => t.Tasks_Id, cascadeDelete: true)
                .ForeignKey("dbo.InfoProjects", t => t.InfoProject_Id, cascadeDelete: true)
                .Index(t => t.Tasks_Id)
                .Index(t => t.InfoProject_Id);
            
            AddPrimaryKey("dbo.StatusWorkTasks", new[] { "StatusWork_Id", "Tasks_Id" });
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.TasksInfoProjects", "InfoProject_Id", "dbo.InfoProjects");
            DropForeignKey("dbo.TasksInfoProjects", "Tasks_Id", "dbo.Tasks");
            DropIndex("dbo.TasksInfoProjects", new[] { "InfoProject_Id" });
            DropIndex("dbo.TasksInfoProjects", new[] { "Tasks_Id" });
            DropPrimaryKey("dbo.StatusWorkTasks");
            DropTable("dbo.TasksInfoProjects");
            AddPrimaryKey("dbo.StatusWorkTasks", new[] { "Tasks_Id", "StatusWork_Id" });
            RenameTable(name: "dbo.StatusWorkTasks", newName: "TasksStatusWorks");
        }
    }
}
