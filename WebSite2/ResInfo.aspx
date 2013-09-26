<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResInfo.aspx.cs" Inherits="WebSite2_ResInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="System.Data.SqlClient"
                SelectCommand="SELECT [pic_id],picture_tag, [pic],pic_small FROM [tb_Pics] where 1=1"></asp:SqlDataSource>
            <asp:ListView ID="Pic_listView" GroupItemCount="4" runat="server" DataKeyNames="pic_id" DataSourceID="sqlDataSource1">
                <LayoutTemplate>
                    <asp:PlaceHolder
                        ID="groupPlaceholder"
                        runat="server" />
                </LayoutTemplate>
                <GroupTemplate>
                    <div>
                        <asp:PlaceHolder
                            ID="itemPlaceholder"
                            runat="server" />
                    </div>
                </GroupTemplate>
                <ItemTemplate>
                    <asp:Image
                        ID="picAlbum" runat="server" Height="120px" Width="120px" AlternateText='<% #Eval("picture_tag")%>'
                        ImageUrl='<%# "ShowImage.ashx?id=" + Eval("pic_id") %>' />
                </ItemTemplate>
                <EmptyItemTemplate>
                </EmptyItemTemplate>
            </asp:ListView>
            <asp:FileUpload ID="openFileDialog" runat="server" />
            <br />
            <asp:TextBox ID="txtTags" runat="server" Width="206px"></asp:TextBox>
            <br />
            <asp:Button ID="butAdd" runat="server" Text="Insert" OnClick="butAdd_Click" />
            <asp:Button ID="butDelete" runat="server" Text="Delete" />
            <asp:Button ID="butClear" runat="server" Text="Clear" />
            <asp:Button ID="butClose" runat="server" Text="Close" /><br />
            <asp:Label ID="UploadStatusLabel" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Panel ID="Panel1" runat="server" Height="287px" Width="565px">
                <asp:Image ID="Image1" runat="server" Height="233px" Width="558px" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
