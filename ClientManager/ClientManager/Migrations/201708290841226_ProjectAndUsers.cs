namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ProjectAndUsers : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.InfoProjects", "Users_Id", c => c.String(maxLength: 128));
            CreateIndex("dbo.InfoProjects", "Users_Id");
            AddForeignKey("dbo.InfoProjects", "Users_Id", "dbo.AspNetUsers", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.InfoProjects", "Users_Id", "dbo.AspNetUsers");
            DropIndex("dbo.InfoProjects", new[] { "Users_Id" });
            DropColumn("dbo.InfoProjects", "Users_Id");
        }
    }
}
