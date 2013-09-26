using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UIinterface.App_Code
{
    /// <summary>
    /// Summary description for MyModule
    /// </summary>
    public class MyModule
    {
        public MyModule()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void FileUpload(FileUpload FileUpload1, Label Label1, ListView listview,TextBox txtTags,Image image)
        {
            string savePath = @"c:\temp\uploads\";
            SqlConnection connection = null;
            if (FileUpload1.HasFile&&FileUpload1.PostedFile!=null)
            {
                string fileContentType = FileUpload1.PostedFile.ContentType;
                if (fileContentType == "image/bmp" || fileContentType == "image/gif" || fileContentType == "image/jpeg")
                {
                    string name = FileUpload1.PostedFile.FileName;                  // 客户端文件路径
                    Byte[] imgByte = null;
                    //To create a PostedFile
                    HttpPostedFile File1 = FileUpload1.PostedFile;
                    //Create byte Array with file len
                    imgByte = new Byte[File1.ContentLength];
                    //force the control to load data in array
                    File1.InputStream.Read(imgByte, 0, File1.ContentLength);
                    FileInfo file = new FileInfo(name);

                    string fileName = file.Name;                                    // 文件名称
                    string fileName_s = "s_" + file.Name;                           // 缩略图文件名称
                    string fileName_sy = "sy_" + file.Name;                         // 水印图文件名称（文字）
                    string fileName_syp = "syp_" + file.Name;                       // 水印图文件名称（图片）
                    string webFilePath = savePath + fileName;        // 服务器端文件路径
                    string webFilePath_s = savePath + fileName_s;　　// 服务器端缩略图路径
                    string webFilePath_sy = savePath + fileName_sy;　// 服务器端带水印图路径(文字)
                    string webFilePath_syp = savePath + fileName_syp;　// 服务器端带水印图路径(图片)
                    string webFilePath_sypf = savePath + "shuiyin.jpg";　// 服务器端水印图路径(图片)
                    
                    if (!File.Exists(webFilePath))
                    {
                        try
                        {
                            FileUpload1.SaveAs(webFilePath);
                            // 使用 SaveAs 方法保存文件
                            AddShuiYinWord(webFilePath, webFilePath_sy);
                            image.ImageUrl = webFilePath_sy;
                            
                            //AddShuiYinPic(webFilePath, webFilePath_syp, webFilePath_sypf);
                            byte[] imgByte_small = MakeThumbnail(webFilePath, webFilePath_s, 130, 130, "Cut", listview);     // 生成缩略图方法
                            Label1.Text = "File“" + fileName + "”Uploaded Successful“" + fileName_s + "”缩略图，文件类型为：" + FileUpload1.PostedFile.ContentType + "，size of file：" + FileUpload1.PostedFile.ContentLength + "B";

                            string conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                            connection = new SqlConnection(conn);
                            connection.Open();
                            string sql = "Insert into tb_Pics(picture_tag,pic,pic_small) Values(@tag,@pic,@pic_small) Select @@Identity";
                            SqlCommand cmd = new SqlCommand(sql, connection);
                            cmd.Parameters.AddWithValue("@tag", txtTags.Text);
                            cmd.Parameters.AddWithValue("@pic", imgByte);
                            cmd.Parameters.AddWithValue("@pic_small", imgByte_small);
                            int id = Convert.ToInt32(cmd.ExecuteScalar());
                            Label1.Text = String.Format("Picture ID is {0}", id);

                            
                        }
                        catch (Exception ex)
                        {
                            Label1.Text = "Error Update Failed：" + ex.Message;
                        }
                        finally
                        {
                            connection.Close();
                        }
                    }
                    else
                    {
                        Label1.Text = "File Already Exists";
                    }
                }
                else
                {
                    Label1.Text = "Error! File don't have the right extension";
                }
            }
        }
        /**/
        /// <summary>
        /// 生成缩略图
        /// </summary>
        /// <param name="originalImagePath">源图路径（物理路径）</param>
        /// <param name="thumbnailPath">缩略图路径（物理路径）</param>
        /// <param name="width">缩略图宽度</param>
        /// <param name="height">缩略图高度</param>
        /// <param name="mode">生成缩略图的方式</param>   
        public static Byte[] MakeThumbnail(string originalImagePath, string thumbnailPath, int width, int height, string mode,ListView listview)
        {
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(originalImagePath);

            int towidth = width;
            int toheight = height;

            int x = 0;
            int y = 0;
            int ow = originalImage.Width;
            int oh = originalImage.Height;

            switch (mode)
            {
                case "HW"://指定高宽缩放（可能变形）               
                    break;
                case "W"://指定宽，高按比例                   
                    toheight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H"://指定高，宽按比例
                    towidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut"://指定高宽裁减（不变形）               
                    if ((double)originalImage.Width / (double)originalImage.Height > (double)towidth / (double)toheight)
                    {
                        oh = originalImage.Height;
                        ow = originalImage.Height * towidth / toheight;
                        y = 0;
                        x = (originalImage.Width - ow) / 2;
                    }
                    else
                    {
                        ow = originalImage.Width;
                        oh = originalImage.Width * height / towidth;
                        x = 0;
                        y = (originalImage.Height - oh) / 2;
                    }
                    break;
                default:
                    break;
            }

            //新建一个bmp图片
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);

            //新建一个画板
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);

            //设置高质量插值法
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

            //设置高质量,低速度呈现平滑程度
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            //清空画布并以透明背景色填充
            g.Clear(System.Drawing.Color.Transparent);

            //在指定位置并且按指定大小绘制原图片的指定部分
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, towidth, toheight),
                new System.Drawing.Rectangle(x, y, ow, oh),
                System.Drawing.GraphicsUnit.Pixel);

            try
            {
                //以jpg格式保存缩略图
                bitmap.Save(thumbnailPath, System.Drawing.Imaging.ImageFormat.Jpeg);
                Byte[] imgByte = ConvertImage(bitmap);
                return imgByte;
                //listview.Items.Add();//System.Drawing.Image.FromFile(thumbnailPath));
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
        }

        private static byte[] ConvertImage(System.Drawing.Image image)
        {
            MemoryStream ms = new MemoryStream();
            BinaryFormatter bf = new BinaryFormatter();
            bf.Serialize(ms, (object)image);
            ms.Close();
            return ms.ToArray();
        }

        private static System.Drawing.Image ReadImage(byte[] bytes)
        {
            MemoryStream ms = new MemoryStream(bytes, 0, bytes.Length);
            BinaryFormatter bf = new BinaryFormatter();
            object obj = bf.Deserialize(ms);
            ms.Close();
            return (System.Drawing.Image)obj;
        }

        /**/
        /// <summary>
        /// 在图片上增加文字水印
        /// </summary>
        /// <param name="Path">原服务器图片路径</param>
        /// <param name="Path_sy">生成的带文字水印的图片路径</param>
        protected void AddShuiYinWord(string Path, string Path_sy)
        {
            string addText = "Copyright Yummy!";
            System.Drawing.Image image = System.Drawing.Image.FromFile(Path);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(image);
            g.DrawImage(image, 0, 0, image.Width, image.Height);
            System.Drawing.Font f = new System.Drawing.Font("Verdana", 16);
            System.Drawing.Brush b = new System.Drawing.SolidBrush(System.Drawing.Color.White);

            g.DrawString(addText, f, b, 15, 15);
            g.Dispose();

            image.Save(Path_sy);
            image.Dispose();
        }

        /**/
        /// <summary>
        /// 在图片上生成图片水印
        /// </summary>
        /// <param name="Path">原服务器图片路径</param>
        /// <param name="Path_syp">生成的带图片水印的图片路径</param>
        /// <param name="Path_sypf">水印图片路径</param>
        protected void AddShuiYinPic(string Path, string Path_syp, string Path_sypf)
        {
            System.Drawing.Image image = System.Drawing.Image.FromFile(Path);
            System.Drawing.Image copyImage = System.Drawing.Image.FromFile(Path_sypf);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(image);
            g.DrawImage(copyImage, new System.Drawing.Rectangle(image.Width - copyImage.Width, image.Height - copyImage.Height, copyImage.Width, copyImage.Height), 0, 0, copyImage.Width, copyImage.Height, System.Drawing.GraphicsUnit.Pixel);
            g.Dispose();

            image.Save(Path_syp);
            image.Dispose();
        }

    }
}