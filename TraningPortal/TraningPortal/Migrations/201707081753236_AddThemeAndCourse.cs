namespace TraningPortal.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddThemeAndCourse : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Courses",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        NameCourse = c.String(),
                        Trainer_Id = c.String(maxLength: 128),
                        Theme_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.Trainer_Id)
                .ForeignKey("dbo.Themes", t => t.Theme_Id)
                .Index(t => t.Trainer_Id)
                .Index(t => t.Theme_Id);
            
            CreateTable(
                "dbo.Themes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        NameTheme = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Courses", "Theme_Id", "dbo.Themes");
            DropForeignKey("dbo.Courses", "Trainer_Id", "dbo.AspNetUsers");
            DropIndex("dbo.Courses", new[] { "Theme_Id" });
            DropIndex("dbo.Courses", new[] { "Trainer_Id" });
            DropTable("dbo.Themes");
            DropTable("dbo.Courses");
        }
    }
}
