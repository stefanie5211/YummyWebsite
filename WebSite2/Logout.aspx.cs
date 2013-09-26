using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSite2_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Remove("Username");
        Session.Remove("Call");
        Literal1.Text = "Log out successfully! Redirecting to homepage.";

        //Response.Redirect("Default.aspx");
        Server.Transfer("Default.aspx");
    }
}