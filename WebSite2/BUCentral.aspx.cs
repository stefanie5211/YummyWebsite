using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSite2_BUCentral : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Session["Restaurantname"] = "McDonalds";
        //Session["Username"] = ""; 
        Server.Transfer("Restaurant.aspx");
    }
    protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
    {
        Session["Restaurantname"] = "Dunkin Donuts";
        //Session["Username"] = ""; 
        Server.Transfer("Restaurant.aspx");
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        Session["Restaurantname"] = "Gyu-Kaku";
        //Session["Username"] = ""; 
        Server.Transfer("Restaurant.aspx");
    }
}