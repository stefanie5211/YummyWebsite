<%@ Page Language="C#" MasterPageFile="~/WebSite2/MasterPage.master" AutoEventWireup="true" CodeFile="BUCentral.aspx.cs" Inherits="WebSite2_BUCentral" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <form id="form1" runat="server">
        <div class="BUcentral">
            <asp:ImageButton ID="ImageButton8" runat="server" Height="233px" ImageUrl="~/WebSite2/Image/BU East/No.9 Park.JPG" Width="310px" OnClick="ImageButton8_Click" />
            <asp:ImageButton ID="ImageButton5" runat="server" Height="233px" ImageUrl="~/WebSite2/Image/BU East/pinkberry.jpg" Width="310px" />
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="Image/BU%20East/shabuzen.jpg" OnClick="ImageButton2_Click" />
            <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/WebSite2/Image/BU East/starbucks.jpg" />
            <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/WebSite2/Image/BU East/unionoyster.jpg" OnClick="ImageButton3_Click" />
            <asp:ImageButton ID="ImageButton6" runat="server" Height="233px" ImageUrl="~/WebSite2/Image/BU East/yard house.jpg" Width="310px" />
            
    </form>
</asp:Content>

