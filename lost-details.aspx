<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lost-details.aspx.cs" Inherits="APT2012.lost_details" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
   <head id="Head1" runat="server">
    <link rel="SHORTCUT ICON" href="~/APTTHEME/APT01/images/APTicon.ico" />    
	<link rel="stylesheet" type="text/css" media="screen" href="~/APTTHEME/APT01/APTglobal-login.css" />
    <title>Allied Pensions Trustees - Lost details</title>  
</head>
<body>

 <div id="container">
      <div id="bookmark1">
		    <div id="bookmarkcontainer1">
			    <a href="#" title="Lost Details Notice" id="bookmarkbutton1">
                <strong>Password Reset Request</strong>
               <br />
                 <br />
               Please complete the password reset request below and our internet security team 
                will re-issue a new password for your account.            
        <br />
        <br />
        <p style="font-size:small;"> Alternatively contact a member of our 
                        internet security team on 01-2063010.</p>
                </a>			    
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
					<label for="email">Email</label>
					<asp:TextBox ID="email" type="text" tabindex="2" name="email"  runat="server"  />
                    <label for="email">Phone number</label>
					<asp:TextBox ID="phone" type="text" tabindex="2" name="phone"  runat="server"  />
					
					<p class="warning"><strong>Note:</strong> a member of APT internet security team will contact you in the next few days.</p>
					
					<input type="submit" id="loginbutton" tabindex="4" value="Request New Password" />			
				</fieldset>			                                        
			</form>                                  
            </div>            
   </div>
   </div>  

</body>
</html>
