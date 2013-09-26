<%@ Page Title="" Language="C#" MasterPageFile="~/WebSite2/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="WebSite2_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
 
    <div class="bodycr">
    <div class="bodyleft" style="float:left;width:473px;height:266px;"><a href="BUWest.aspx" style="color:#f00;text-decoration:none"onmouseover="this.style.color='#ffffff'" onmouseout="this.style.color='#ff0000'">BU West</a></div>
    <div class="bodycenter"style="float:right;height:266px; width:473px"><a href="BUCentral.aspx" style="color:#fff;text-decoration:none"onmouseover="this.style.color='#ff0000'" onmouseout="this.style.color='#FFFFFF'">BU Central</a></div>
    <div class="bodyright" style="float:left;height: 266px; width: 473px;"><a href="BUEast.aspx" style="color:#FFFFFF;text-decoration:none"onmouseover="this.style.color='#ff0000'" onmouseout="this.style.color='#FFFFFF'">BU East</a></div>
    <div class="bodyrightright" style="float:right;height: 266px; width: 473px;"><a href="AroundBU.aspx" style="color:#ff0000;text-decoration:none"onmouseover="this.style.color='#ffffff'" onmouseout="this.style.color='#ff0000'">Around BU</a></div>      
</div>
        
</asp:Content>


