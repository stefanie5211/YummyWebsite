using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UIinterface.App_Code;

public partial class WebSite2_ResInfo : System.Web.UI.Page
{
    public List<Image> pic = new List<Image>();//存放大图 
    MyModule MyMC = new MyModule();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void butAdd_Click(object sender, EventArgs e)
    {
        MyMC.FileUpload(openFileDialog, UploadStatusLabel, Pic_listView, txtTags,Image1);
    }
}