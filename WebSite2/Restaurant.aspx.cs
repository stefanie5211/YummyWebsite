using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class WebSite2_Default2 : System.Web.UI.Page
{
    static String RestaurantName = null;
    static String UserName = null;
    static String UserCall = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            RestaurantName = Session["Restaurantname"].ToString();
            LabelRname.Text = RestaurantName;
            //Session.Remove("Restaurantname");
            Image1.ImageUrl = "~/WebSite2/Image/BU Central/" + RestaurantName + ".jpg";
            string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
            string selectString = "SELECT * FROM tb_Restaurant WHERE Name='" + RestaurantName +"'";//select string for search currency name correspond with the input
            SqlDataSource dsrc = new SqlDataSource(conString, selectString);
            DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
            LabelAddress.Text = DV.Table.Rows[0][2].ToString();
            LabelContact.Text = DV.Table.Rows[0][3].ToString();
            LabelCuisine.Text = DV.Table.Rows[0][4].ToString();
            float a = float.Parse(DV.Table.Rows[0][5].ToString());

            float b = (float)(Math.Round(a * 100)) / 100; 
            LabelRate.Text = b.ToString();

            LabelDescription.Text = DV.Table.Rows[0][7].ToString();

        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
        try
        {
            UserName = Session["Username"].ToString();
            UserCall = Session["Call"].ToString();
            string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
            string selectString = "SELECT * FROM tb_Review WHERE Uname='" + UserCall + "' AND Rname='" + RestaurantName + "'";//select string for search currency name correspond with the input
            SqlDataSource dsrc = new SqlDataSource(conString, selectString);
            DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
            if (DV.Table.Rows.Count > 0)
            {
                LabelReviewRate.Visible = false;
                LabelReviewContent.Visible = false;
                TextBoxRate.Visible = false;
                TextBox1.Visible = false;
                Button1.Visible = false;
            }
        }
        catch (Exception ex)
        {
            LabelReviewRate.Visible = false;
            LabelReviewContent.Visible = false;
            TextBoxRate.Visible = false;
            TextBox1.Visible = false;
            Button1.Visible = false;
            Console.WriteLine(ex.ToString());
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime date = DateTime.Now;
        string content = TextBox1.Text.Trim();
        float rate=float.Parse(TextBoxRate.Text.Trim());
        string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
        SqlConnection conn = new SqlConnection(conString);
        conn.Open();
        SqlCommand cmd = conn.CreateCommand();
        cmd.CommandText = "INSERT INTO tb_Review (Rname, Uname, Content, Date, Rate)VALUES ('" + RestaurantName + "', '" + Session["Call"] + "', '" + content + "', '" + date + "','"+rate+"')";
        cmd.ExecuteNonQuery();

        //Complete Insertion then update new rate
        string conString2 = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
        string selectString = "SELECT * FROM tb_Review WHERE Rname='" + RestaurantName + "'";//select string for search currency name correspond with the input
        SqlDataSource dsrc = new SqlDataSource(conString2, selectString);
        DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
        int rowsCount=DV.Table.Rows.Count;
        float Ratesum=0;
        float newRate = 0;
        if (rowsCount > 0)
        {
            for(int i=0;i<rowsCount;i++)
                Ratesum+=float.Parse(DV.Table.Rows[i][5].ToString());
            newRate = Ratesum / rowsCount;
            cmd.CommandText = "Update tb_Restaurant set Rate='"+newRate+"',Ratenum='"+rowsCount+"' where Name='"+RestaurantName+"'";
            cmd.ExecuteNonQuery();
        }
        conn.Close();
        TextBox1.Visible = false;
        Button1.Visible = false;
        
        Session["Restaurantname"] = RestaurantName;
        Session["Username"] = UserName;
        Server.Transfer("Restaurant.aspx");
        //Response.Redirect(Request.Url.ToString()); 
        //string selectString = "INSERT INTO tb_Review (Rname, Uname, Content, Date)VALUES ('RestaurantName', 'Username', 'content', 'date')";//select string for search currency name correspond with the input
        //SqlDataSource dsrc = new SqlDataSource(conString, selectString);
    }
    protected void ButtonMore_Click(object sender, EventArgs e)
    {
        Session["Restaurantname"] = RestaurantName;
        Session["Username"] = UserName;
        Server.Transfer("MoreReviews.aspx");
    }
}