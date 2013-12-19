<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="APT2012.login"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="SHORTCUT ICON" href="~/APTTHEME/APT01/images/APTicon.ico" />    
	<link rel="stylesheet" type="text/css" media="screen" href="~/APTTHEME/APT01/APTglobal-login.css" />
    <title>Allied Pensions Trustees Login</title>
</head>
<body>
    
    <div id="container">
    <div id="bookmark">
		<div id="bookmarkcontainer">
			<!--a href="#" title="Bookmark this page" id="bookmarkbutton"><strong>Bookmark</strong> this page</a>
			<a href="#" title="Do not ask me this anymore" id="close">x</a-->
		</div>
	</div>    

	<div id="left">	
		<div id="hometab">
			<a href="http://www.alliedpensions.com" title="go to the homepage">Home</a>
		</div>
        <div id="loginbox">
            <div id="APTlogo">
				<a href="http://www.alliedpensions.com" title="Allied Pensions Trustees">Allied Pensions Trustees</a>
			</div>		
             
            <form autocomplete="off" name="login" id="login" runat="server">
				
                <fieldset>
					<label for="account_id">Username</label>		
					<asp:TextBox ID="account_id" type="text" tabindex="1" name="account_id" runat="server" />
					<label for="password">Password</label>
					<asp:TextBox ID="password" TextMode="Password" type="password" tabindex="2" name="password"  runat="server"  />

					<div id="rememberbox">
						<label for="remember" id="rememberlabel">Remember my username</label>
						<asp:CheckBox ID="chbxRememberMe"  tabindex="3" runat="server" />
					</div>
					<p class="warning"><strong>Warning:</strong> only tick this box if you are using a trusted computer</p>
					
					<input type="submit" id="loginbutton" tabindex="4" value="Log in" />			
				</fieldset>
			
                    <asp:Panel id="APTLoginResult" runat="server" Visible="true"> 
                    <div id="LoginFailurePanel">
			                <span>Your login attempt was not successful. Please try again.</span>
                    </div> 		
                    </asp:Panel>                            
			</form>
              
            <p></p>
           <div id="loginoptions">
				<a rel="nofollow" class="lostDetails" href="lost-details.aspx">Lost your details?</a>
				<a href="http://www.alliedpensions.com/contact.aspx" class="openAccount">Apply for an account</a>
			</div>
            </div>
   </div>

              <script type="text/javascript">
                  checkLoginPageUsernameCookie();
                  function getLoginPageCookie(cookieName) {
                      var i, x, y, arrCookies = document.cookie.split(";");
                      for (i = 0; i < arrCookies.length; i++) {
                          x = arrCookies[i].substr(0, arrCookies[i].indexOf("="));
                          y = arrCookies[i].substr(arrCookies[i].indexOf("=") + 1);
                          x = x.replace(/^\s+|\s+jq/g, "");
                          if (x == cookieName) {
                              return unescape(y);
                          }
                      }
                  }
                  function checkLoginPageUsernameCookie() {
                      var usernameCookie = getLoginPageCookie("un");
                      if (usernameCookie != null && usernameCookie != "") {
                          document.getElementById("password").focus();
                          document.getElementById("account_id").value = usernameCookie;
                          document.getElementById("remember").checked = true;
                      }
                  }
			</script>		
    </div>
   
</body>
</html>

