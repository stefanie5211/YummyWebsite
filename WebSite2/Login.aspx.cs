using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
        string selectString = "SELECT * FROM tb_Userinfo WHERE Username='" + Login1.UserName + "'";//select string for search currency name correspond with the input
        SqlDataSource dsrc = new SqlDataSource(conString, selectString);
        DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count > 0)
        {
            string password = (string)DV.Table.Rows[0][7];
            if (password.Equals(Login1.Password))
            {
                //Label1.Text = "Congratulations! Login succeed! Please wait for redirect to Homepage!";
                Session["Username"] = Login1.UserName;
                Session["Call"] = DV.Table.Rows[0][1].ToString();
                Server.Transfer("~/WebSite2/Default.aspx");
                //Response.Write("<script language=javascript>alert('Congratulations! Login succeed!')</script>");
                //System.Threading.Thread.Sleep(5000);
                //Response.Redirect("~/WebSite2/Default.aspx");
            }
            else
                e.Authenticated = false;
        }
        else
            e.Authenticated = false;
    }
    protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
    {
        
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        
    }
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        
    }
    protected void SubmitButton_Click1(object sender, EventArgs e)
    {
        string conString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=|DataDirectory|\\Yummy.mdf;Integrated Security=True";
        string selectString = "SELECT * FROM tb_Userinfo WHERE Username='" + PasswordRecovery1.UserName + "'";//select string for search currency name correspond with the input
        SqlDataSource dsrc = new SqlDataSource(conString, selectString);
        DataView DV = (DataView)dsrc.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count > 0)
        {

            Session["UserForgetName"] = PasswordRecovery1.UserName;
            Server.Transfer("ForgetPassword.aspx");
        }
        else
            PasswordRecovery1.UserNameFailureText = "Username not exists! ";
    }
}