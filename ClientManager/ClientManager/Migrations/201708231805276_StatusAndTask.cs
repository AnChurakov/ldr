namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class StatusAndTask : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.StatusWorks",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Tasks",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Name = c.String(),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.TasksStatusWorks",
                c => new
                    {
                        Tasks_Id = c.Guid(nullable: false),
                        StatusWork_Id = c.Guid(nullable: false),
                    })
                .PrimaryKey(t => new { t.Tasks_Id, t.StatusWork_Id })
                .ForeignKey("dbo.Tasks", t => t.Tasks_Id, cascadeDelete: true)
                .ForeignKey("dbo.StatusWorks", t => t.StatusWork_Id, cascadeDelete: true)
                .Index(t => t.Tasks_Id)
                .Index(t => t.StatusWork_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.TasksStatusWorks", "StatusWork_Id", "dbo.StatusWorks");
            DropForeignKey("dbo.TasksStatusWorks", "Tasks_Id", "dbo.Tasks");
            DropIndex("dbo.TasksStatusWorks", new[] { "StatusWork_Id" });
            DropIndex("dbo.TasksStatusWorks", new[] { "Tasks_Id" });
            DropTable("dbo.TasksStatusWorks");
            DropTable("dbo.Tasks");
            DropTable("dbo.StatusWorks");
        }
    }
}
