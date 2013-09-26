<%@ Page Title="" Language="C#" MasterPageFile="~/WebSite2/MasterPage.master" AutoEventWireup="true" CodeFile="MoreReviews.aspx.cs" Inherits="WebSite2_MoreReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 5 [Uname], [Content], [Date], [Rate] FROM [tb_Review] WHERE ([Rname] = @Rname) ORDER BY [Date] DESC">
            <SelectParameters>
                <asp:SessionParameter Name="Rname" SessionField="Restaurantname" Type="String" />
            </SelectParameters>
</asp:SqlDataSource>

<asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" GridLines="Horizontal" Height="16px" RepeatColumns="1" RepeatDirection="Horizontal" Width="600px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center">
            <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="True" Font-Names="Bradley Hand ITC" Font-Size="XX-Large" />
            <HeaderTemplate>
                Recent Reviews:
            </HeaderTemplate>
            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Font-Names="Bradley Hand ITC" Font-Size="XX-Large" />
            <ItemTemplate>
                User:
                <asp:Label ID="UnameLabel" runat="server" Text='<%# Eval("Uname") %>' />
                <br />
                Content:
                <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                <br />
                Date:
                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                <br />
                Rate:
                <asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
    </form>
</asp:Content>

