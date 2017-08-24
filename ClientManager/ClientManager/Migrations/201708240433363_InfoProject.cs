namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InfoProject : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.InfoProjects",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Name = c.String(),
                        Description = c.String(),
                        LinkSubdomen = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.InfoProjects");
        }
    }
}
