<%@ Page Language="C#" MasterPageFile="~/WebSite2/MasterPage.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="WebSite2_Register" %>



<script runat="server">
              
      

    </script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <style type="text/css">
        #form1 {
            height: 1078px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <form id="form1" runat="server">
        <div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [tb_Userinfo]" InsertCommand="INSERT INTO tb_Userinfo(Call, gender, email, phone, Username, Pwd, SecurityQuestion, Answer, area) VALUES (@newCall, @newgender, @newemail, @newphone, @newusername, @newpassword, @newSQ, @newanswer, @newarea)" UpdateCommand="UPDATE tb_Userinfo SET Call = @call, email = @email, gender = @gender, area = @area, phone = @phone, Pwd = @password where Username = @username">
                <InsertParameters>
                    <asp:ControlParameter ControlID="Call" Name="newCall" PropertyName="Text" />
                    <asp:ControlParameter ControlID="RadioGenderList" Name="newgender" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="email" DefaultValue="" Name="newemail" PropertyName="Text" />
                    <asp:ControlParameter ControlID="Phone" Name="newphone" PropertyName="Text" />
                    <asp:ControlParameter ControlID="username" DefaultValue="" Name="newusername" PropertyName="Text" />
                    <asp:ControlParameter ControlID="password" Name="newpassword" PropertyName="Text" />
                    <asp:ControlParameter ControlID="DropDownListSQ" Name="newSQ" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="Answer" DefaultValue="" Name="newanswer" PropertyName="Text" />
                    <asp:ControlParameter ControlID="RadioAreaList" Name="newarea" PropertyName="SelectedValue" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="Call" Name="call" PropertyName="Text" />
                    <asp:ControlParameter ControlID="email" Name="email" PropertyName="Text" />
                    <asp:ControlParameter ControlID="Phone" Name="phone" PropertyName="Text" />
                    <asp:ControlParameter ControlID="RadioAreaList" Name="area" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioGenderList" Name="gender" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="password" Name="password" PropertyName="Text" />
                    <asp:ControlParameter ControlID="passwordConfirm" Name="cpassword" PropertyName="Text" />
                    <asp:SessionParameter Name="username" SessionField="Username" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [tb_SecurityQuestion]"></asp:SqlDataSource>


        </div>

        <div class="bodyword" style="width:400px; margin-left:auto;margin-right:auto">
            Create a new account
            <p>
                Username:
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            </p>
            <p>
                Password:&nbsp;
            <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
            </p>
            <p>
                Confirm your password:
            <asp:TextBox ID="passwordConfirm" runat="server" TextMode="Password"></asp:TextBox>
            </p>
            <p>
                Security Question:
                <asp:DropDownList ID="DropDownListSQ" runat="server" DataSourceID="SqlDataSource3" DataTextField="QuestionText" DataValueField="QuestionText">
                </asp:DropDownList>
            </p>
            <p>
                Answer:
            <asp:TextBox ID="Answer" runat="server" Width="279px"></asp:TextBox>
            </p>
            Personal Information:

            <p>
                Call:
            <asp:TextBox ID="Call" runat="server" Width="163px"></asp:TextBox>
            </p>
            <p>
                Gender:
                <asp:RadioButtonList ID="RadioGenderList" runat="server" Width="175px">
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:RadioButtonList>
            </p>
            <p>
                Email:
                <asp:TextBox ID="email" runat="server"></asp:TextBox>
            </p>
            <p>
                Phone number:
            <asp:TextBox ID="Phone" runat="server"></asp:TextBox>
            </p>
            <p>
                Address Area:<asp:RadioButtonList ID="RadioAreaList" runat="server">
                    <asp:ListItem>BuWest</asp:ListItem>
                    <asp:ListItem>BuCentral</asp:ListItem>
                    <asp:ListItem>BuEast</asp:ListItem>
                    <asp:ListItem>BuOther</asp:ListItem>
                </asp:RadioButtonList>
            </p>
            <p>
                <asp:Button ID="Register" runat="server" Text="Register" OnClick="Register_Click" Height="53px" Width="137px" />
            </p>
            <p>
                <a href="Login.aspx">Login</a>
            </p>
            <p>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </p>
        </div>

    </form>
    </asp:Content>
