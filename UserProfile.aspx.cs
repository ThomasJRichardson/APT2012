using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Data.Objects;
using System.Web.Security;
using System.Web.Profile;
using System.Data;
using System.Web.Caching;
using System.Diagnostics;
using APT.UTIL;


namespace APT2012
{
    public partial class UserProfile : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] == null)
                    {
                        return;
                    }

                    int selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                    Member member = Member.GetMemberById(selectedMemberId);
                    if (member == null)
                    {
                        return;
                    }

                    pnlContactInfo.Visible = true;

                    string selectedUserName = ASPProfile.getSelectedUserName(selectedMemberId);
                    if (HttpContext.Current.Session["SelectedSchemeId"] == null)
                        return;

                    int schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];


                    if (selectedUserName != null)
                    {
                        lblUserNameValue.Text = selectedUserName;
                        ProfileBase userProfile = ProfileBase.Create(selectedUserName);

                        txtEmailAddress.Text = Membership.GetUser(selectedUserName).Email;
                        txtHomeTelephoneNo.Text = userProfile.GetPropertyValue("PhoneHome").ToString();
                        txtOfficeTelephoneNo.Text = userProfile.GetPropertyValue("PhoneOffice").ToString();
                        txtMobileTelephoneNo.Text = userProfile.GetPropertyValue("PhoneMobile").ToString();
                        txtFacsimileNo.Text = userProfile.GetPropertyValue("Fax").ToString();
                        txtAddress1.Text = userProfile.GetPropertyValue("Address1").ToString();
                        txtAddress2.Text = userProfile.GetPropertyValue("Address2").ToString();
                        txtAddress3.Text = userProfile.GetPropertyValue("Address3").ToString();
                        txtAddress4.Text = userProfile.GetPropertyValue("Address4").ToString();
                        //txtCounty.Text = userProfile.GetPropertyValue("County").ToString(); // BB - TODO - ENABLE County and Country in userprofile edit
                        //txtCountry.Text = userProfile.GetPropertyValue("Country").ToString();
                        rblPreferredContactMethod.SelectedValue = userProfile.GetPropertyValue("ContactMethod").ToString();
                    }
                    else
                    {
                        pnlContactInfo.Visible = false;
                        pnlNoUser.Visible = true;
                    }

                    lblNameValue.Text = member.Forename + " " + member.Surname;
                    lblPPSNoValue.Text = member.PPSN;

                    Scheme scheme = Scheme.GetSchemeDetails(schemeId);
                    lblSchemeValue.Text = scheme.Description;
                }
            }             
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnUpdateContactDetails_Click(object sender, EventArgs e)
        {
            try
            {
                ProfileBase userProfile = ProfileBase.Create(ASPProfile.getSelectedUserName((int)HttpContext.Current.Session["SelectedMemberId"]));
                if (userProfile != null)
                {

                    userProfile.SetPropertyValue("PhoneHome", txtHomeTelephoneNo.Text);
                    userProfile.SetPropertyValue("PhoneOffice", txtOfficeTelephoneNo.Text);
                    userProfile.SetPropertyValue("PhoneMobile", txtMobileTelephoneNo.Text);
                    userProfile.SetPropertyValue("Fax", txtFacsimileNo.Text);
                    userProfile.SetPropertyValue("Address1", txtAddress1.Text);
                    userProfile.SetPropertyValue("Address2", txtAddress2.Text);
                    userProfile.SetPropertyValue("Address3", txtAddress3.Text);
                    userProfile.SetPropertyValue("Address4", txtAddress4.Text);
                    userProfile.SetPropertyValue("ContactMethod", rblPreferredContactMethod.SelectedValue);
                    userProfile.Save();

                    MembershipUser mu = Membership.GetUser(userProfile.UserName);
                    mu.Email = txtEmailAddress.Text;
                    Membership.UpdateUser(mu);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }
    }
}
