namespace ClientManager.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpProject : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.InfoProjects", "Progress", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.InfoProjects", "Progress");
        }
    }
}
