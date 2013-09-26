using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class WebSite2_About : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string username = Session["Username"].ToString();
            string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
            string selectString = "SELECT * FROM tb_Userinfo WHERE Username='" + username + "'";//select string for search currency name correspond with the input
            SqlDataSource dsrc = new SqlDataSource(conString, selectString);   
            DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
            Call.Text = DV.Table.Rows[0][1].ToString();
            Gender.Text = DV.Table.Rows[0][2].ToString();
            email.Text = DV.Table.Rows[0][3].ToString();
            phone.Text = DV.Table.Rows[0][5].ToString();
            area.Text = DV.Table.Rows[0][4].ToString();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        Server.Transfer("Register.aspx");
    }
}