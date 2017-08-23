namespace TraningPortal.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTheme : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Courses", "Theme_Id", "dbo.Themes");
            DropIndex("dbo.Courses", new[] { "Theme_Id" });
            AddColumn("dbo.Themes", "Course_Id", c => c.Int());
            CreateIndex("dbo.Themes", "Course_Id");
            AddForeignKey("dbo.Themes", "Course_Id", "dbo.Courses", "Id");
            DropColumn("dbo.Courses", "Theme_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Courses", "Theme_Id", c => c.Int());
            DropForeignKey("dbo.Themes", "Course_Id", "dbo.Courses");
            DropIndex("dbo.Themes", new[] { "Course_Id" });
            DropColumn("dbo.Themes", "Course_Id");
            CreateIndex("dbo.Courses", "Theme_Id");
            AddForeignKey("dbo.Courses", "Theme_Id", "dbo.Themes", "Id");
        }
    }
}
