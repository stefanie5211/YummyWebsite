using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSite2_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Label1.Text = "Hello, Welcome back: " + Session["Call"].ToString() + "!";
            Label1.Visible = true;
            Label2.Visible = false;
            Label3.Visible = false;
            L1.Visible = true;
            L2.Visible = true;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
        try
        {
            Label1.Text = "Hello, Welcome first time: " + Session["RegisterInfo"].ToString() + "!";
            Label1.Visible = true;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
    }
}
