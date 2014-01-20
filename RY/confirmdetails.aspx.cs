using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using APT.UTIL;
using APT2012.RY.Enums;
using APTIPPPDataModel;
using APTIPPPDataModel.Classes;


namespace APT2012.RY
{
    public partial class confirmdetails : System.Web.UI.Page
    {
        private IPPPEntities _context = new IPPPEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    btnSubmit.Text = Utility.GetAppSettingValue("submitButtonCaption");
                    BindDropDown();
                    LoadData();
                    //  ShowHideButton();
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }

        }

        private void BindDropDown()
        {
            /*Bind Cofirm Radio Button List*/
            rblConfirm.DataSource = GetConfrimMessageList();
            rblConfirm.DataTextField = "Text";
            rblConfirm.DataValueField = "Value";
            rblConfirm.DataBind();



            /*Bind Gender Dropdown*/
            ddlGender.DataSource = GetGenderList();
            ddlGender.DataTextField = "Text";
            ddlGender.DataValueField = "Value";
            ddlGender.DataBind();

            /*Bind Marital Status Dropdown*/
            ddlMaritalStatus.DataSource = GetMaritalStatusList();
            ddlMaritalStatus.DataTextField = "Text";
            ddlMaritalStatus.DataValueField = "Value";
            ddlMaritalStatus.DataBind();


            /*Bind Read only Employment Dropdown*/
            ddlEmployment1.DataSource = GetList();
            ddlEmployment1.DataTextField = "Text";
            ddlEmployment1.DataValueField = "Value";
            ddlEmployment1.DataBind();

            ddlEmployment.DataSource = GetList();
            ddlEmployment.DataTextField = "Text";
            ddlEmployment.DataValueField = "Value";
            ddlEmployment.DataBind();
            /*Bind Read only Employment Dropdown Ends*/

            /*Bind Editable Employment Dropdown*/
            ddlEEmployment1.DataSource = GetList();
            ddlEEmployment1.DataTextField = "Text";
            ddlEEmployment1.DataValueField = "Value";
            ddlEEmployment1.DataBind();

            ddlEEmployment.DataSource = GetList();
            ddlEEmployment.DataTextField = "Text";
            ddlEEmployment.DataValueField = "Value";
            ddlEEmployment.DataBind();
            /*Bind Read only Employment Dropdown Ends*/


            ddlSchemecategory.DataSource = GetSchemeCatgoryList();
            ddlSchemecategory.DataTextField = "Text";
            ddlSchemecategory.DataValueField = "Value";
            ddlSchemecategory.DataBind();

            ddlSchemeCategory1.DataSource = GetSchemeCatgoryList();
            ddlSchemeCategory1.DataTextField = "Text";
            ddlSchemeCategory1.DataValueField = "Value";
            ddlSchemeCategory1.DataBind();

            ddlESchemeCategory1.DataSource = GetSchemeCatgoryList();
            ddlESchemeCategory1.DataTextField = "Text";
            ddlESchemeCategory1.DataValueField = "Value";
            ddlESchemeCategory1.DataBind();

            ddlESchemeCategory.DataSource = GetSchemeCatgoryList();
            ddlESchemeCategory.DataTextField = "Text";
            ddlESchemeCategory.DataValueField = "Value";
            ddlESchemeCategory.DataBind();
        }

        private void LoadData()
        {
            IPWeb ipweb = new IPWeb();
            var ipWebData = ipweb.GetByUserName(User.Identity.Name);
            if (ipWebData != null)
            {
                /*Personal Details Start*/
                txtPPSN.Text = ipWebData.PPSN;
                txtSurname.Text = ipWebData.Surname;
                txtForename.Text = ipWebData.Forename;
                txtAddress.Text = ipWebData.Address1;
                txtAddress2.Text = ipWebData.Address2;
                txtAddress3.Text = ipWebData.Address3;
                txtAddress4.Text = ipWebData.Address4;
                txtHomePhone.Text = ipWebData.PhoneHome;
                txtMobile.Text = ipWebData.PhoneMobile;
                txtEmailAddress.Text = ipWebData.Email;
                if (ipWebData.DateOfBirth.Value != null)
                    txtDOB.Text = ipWebData.DateOfBirth.Value.ToString(@"dd/MM/yyyy");
                if (ddlGender.Items.FindByValue(ipWebData.Gender) != null)
                {
                    ddlGender.SelectedIndex = ddlGender.Items.IndexOf(ddlGender.Items.FindByValue(ipWebData.Gender));
                }
                if (ddlMaritalStatus.Items.FindByValue(ipWebData.MaritalStatus) != null)
                {
                    ddlMaritalStatus.SelectedIndex = ddlMaritalStatus.Items.IndexOf(ddlMaritalStatus.Items.FindByValue(ipWebData.MaritalStatus));
                }
                /*Personal Details Ends */

                /*Read Only Service Record 1 start*/
                txtDSCommenced.Text = ipWebData.DateEmpStart_1.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateEmpCease_1 != null)
                    txtDSCeased.Text = ipWebData.DateEmpCease_1.Value.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateJoinedScheme_1 != null)
                    txtDJScheme.Text = ipWebData.DateJoinedScheme_1.Value.ToString(@"dd/MM/yyyy");
                if (ddlSchemecategory.Items.FindByValue(ipWebData.SchemeCategory_1) != null)
                {
                    ddlSchemecategory.SelectedIndex = ddlSchemecategory.Items.IndexOf(ddlSchemecategory.Items.FindByValue(ipWebData.SchemeCategory_1));
                }
                if (ipWebData.PensionableSalary_1 != null)
                    txtPSal.Text = ipWebData.PensionableSalary_1.ToString();
                if (ddlEmployment.Items.FindByValue(ipWebData.TransferIn_1) != null)
                {
                    ddlEmployment.SelectedIndex = ddlEmployment.Items.IndexOf(ddlEmployment.Items.FindByValue(ipWebData.TransferIn_1));
                }
                if (ipWebData.NormalRetDate_1 != null)
                    txtNRetDate.Text = ipWebData.NormalRetDate_1.Value.ToString(@"dd/MM/yyyy");
                /*Read Only Service Record 1 End*/

                /*Read Only Service Record 2 start*/
                if (ipWebData.DateEmpStart_2 != null)
                {
                    txtDSCommenced1.Text = ipWebData.DateEmpStart_2.Value.ToString(@"dd/MM/yyyy");

                    txtDSCeased1.Text = ipWebData.DateEmpCease_2.ToString();
                    if (ipWebData.DateJoinedScheme_2 != null)
                        txtDJScheme1.Text = ipWebData.DateJoinedScheme_2.Value.ToString(@"dd/MM/yyyy");
                    if (ddlSchemeCategory1.Items.FindByValue(ipWebData.SchemeCategory_2) != null)
                    {
                        ddlSchemeCategory1.SelectedIndex = ddlSchemeCategory1.Items.IndexOf(ddlSchemeCategory1.Items.FindByValue(ipWebData.SchemeCategory_2));
                    }
                    txtPSal1.Text = ipWebData.PensionableSalary_2.ToString();
                    if (ddlEEmployment1.Items.FindByValue(ipWebData.TransferIn_2) != null)
                        ddlEmployment1.SelectedIndex = ddlEmployment1.Items.IndexOf(ddlEmployment1.Items.FindByValue(ipWebData.TransferIn_2));
                    if (ipWebData.NormalRetDate_2 != null)
                        txtNRetDate1.Text = ipWebData.NormalRetDate_2.Value.ToString(@"dd/MM/yyyy");
                }
                /*Read Only Service Record 2 start*/




                /*Editable Service Record 1 start*/
                if (ipWebData.DateEmpStart_m1 != null)
                    txtEDSCommenced.Text = ipWebData.DateEmpStart_m1.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateEmpCease_m1 != null)
                    txtEDSCeased.Text = ipWebData.DateEmpCease_m1.Value.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateJoinedScheme_m1 != null)
                    txtEDJScheme.Text = ipWebData.DateJoinedScheme_m1.Value.ToString(@"dd/MM/yyyy");
                if (ddlESchemeCategory.Items.FindByValue(ipWebData.SchemeCategory_m1) != null)
                    ddlESchemeCategory.SelectedIndex = ddlESchemeCategory.Items.IndexOf(ddlESchemeCategory.Items.FindByValue(ipWebData.SchemeCategory_m1));

                if (ipWebData.PensionableSalary_m1 != null)
                    txtEPSal.Text = ipWebData.PensionableSalary_m1.ToString();
                if (ddlEEmployment.Items.FindByValue(ipWebData.TransferIn_m1) != null)
                    ddlEEmployment.SelectedIndex = ddlEEmployment.Items.IndexOf(ddlEEmployment.Items.FindByValue(ipWebData.TransferIn_m1));
                if (ipWebData.NormalRetDate_m1 != null)
                    txtENRetDate.Text = ipWebData.NormalRetDate_m1.Value.ToString(@"dd/MM/yyyy");
                /*Editable Service Record 1 End*/

                /*Editable Service Record 2 start*/
                if (ipWebData.DateEmpStart_m2 != null)
                    txtEDSCommenced1.Text = ipWebData.DateEmpStart_m2.Value.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateEmpCease_m2 != null)
                    txtEDSCeased1.Text = ipWebData.DateEmpCease_m2.Value.ToString(@"dd/MM/yyyy");
                if (ipWebData.DateJoinedScheme_m2 != null)
                    txtEDJScheme1.Text = ipWebData.DateJoinedScheme_m2.Value.ToString(@"dd/MM/yyyy");
                if (ddlEEmployment1.Items.FindByValue(ipWebData.TransferIn_m2) != null)
                    ddlEEmployment1.SelectedIndex = ddlEEmployment1.Items.IndexOf(ddlEEmployment1.Items.FindByValue(ipWebData.TransferIn_m2));
                if (ipWebData.PensionableSalary_m2 != null)
                    txtEPSal1.Text = ipWebData.PensionableSalary_m2.ToString();
                if (ddlESchemeCategory1.Items.FindByValue(ipWebData.SchemeCategory_m2) != null)
                    ddlESchemeCategory1.SelectedIndex = ddlESchemeCategory1.Items.IndexOf(ddlESchemeCategory1.Items.FindByValue(ipWebData.SchemeCategory_m2));
                if (ipWebData.NormalRetDate_m2 != null)
                    txtENRetDate1.Text = ipWebData.NormalRetDate_m2.Value.ToString(@"dd/MM/yyyy");
                /*EditableService Record 2 Ends*/


                if (ipWebData.blnCorrect != null)
                {
                    var value = ipWebData.blnCorrect.Value.ToString().ToLower();
                    if (rblConfirm.Items.FindByValue(value) != null)
                        rblConfirm.Items.FindByValue(value).Selected = true;
                }

                pnlSRecord2.Visible = (ipWebData.DateEmpStart_2 != null);
                pnlESRecord.Visible = (ipWebData.DateEmpStart_2 != null);
                lblServices.Visible = (ipWebData.MemberServiceUpdateAt != null);

                if (ipWebData.ProfileLastUpdateAt != null)
                {


                    var pesonalDetailMessage = Utility.GetAppSettingValue("PesonalDetailMessage");
                    Messages objMessage = new Messages();
                    objMessage.by_whom = ipWebData.ProfileLastUpdateBy;
                    if (ipWebData.ProfileLastUpdateBy.ToUpper() == "MEMBER")
                        objMessage.by_whom = Utility.GetAppSettingValue("by_whom_member");
                    else if (ipWebData.ProfileLastUpdateBy.ToUpper() == "APT")
                        objMessage.by_whom = Utility.GetAppSettingValue("by_whom_APT");
                    objMessage.date = ipWebData.ProfileLastUpdateAt.Value;
                    objMessage.time = ipWebData.ProfileLastUpdateAt.Value.TimeOfDay;
                    pesonalDetailMessage = objMessage.FormatMessage(pesonalDetailMessage);

                    lblPersonal.Text = pesonalDetailMessage;
                }


                if (ipWebData.MemberServiceUpdateAt != null)
                {
                    var amendmentRecordsMessage = Utility.GetAppSettingValue("AmendmentRecordsMessage");
                    Messages amendmentMessage = new Messages();
                    amendmentMessage.date = ipWebData.MemberServiceUpdateAt.Value;
                    amendmentMessage.time = ipWebData.MemberServiceUpdateAt.Value.TimeOfDay;
                    amendmentRecordsMessage = amendmentMessage.FormatMessage(amendmentRecordsMessage);
                    lblServices.Text = amendmentRecordsMessage;
                }


                if (ipWebData.ServiceLastUpdateAt != null)
                {


                    var serviceRecordMessage = Utility.GetAppSettingValue("ServiceRecordsMessage");
                    Messages objMessage = new Messages();
                    //objMessage.by_whom = ipWebData.ProfileLastUpdateBy;
                    //if (ipWebData.S.ProfileLastUpdateBy.ToUpper() == "MEMBER")
                    //    objMessage.by_whom = Utility.GetAppSettingValue("by_whom_member");
                    //else if (ipWebData.ProfileLastUpdateBy.ToUpper() == "APT")
                    //    objMessage.by_whom = Utility.GetAppSettingValue(" by_whom_APT");
                    objMessage.date = ipWebData.ServiceLastUpdateAt.Value;
                    objMessage.time = ipWebData.ServiceLastUpdateAt.Value.TimeOfDay;
                    serviceRecordMessage = objMessage.FormatMessage(serviceRecordMessage);

                    lblServiceRecordUpdated.Text = serviceRecordMessage;
                }



            }
        }

        private List<ListItem> GetGenderList()
        {
            List<ListItem> list = new List<ListItem>();
            var enumsValues = Enum.GetNames(typeof(GenderType));
            foreach (var item in enumsValues)
            {
                ListItem obj = new ListItem();
                obj.Value = item;
                if (item.ToLower() == "m")
                    obj.Text = "Male";
                else
                    obj.Text = "Female";

                list.Add(obj);
            }
            return list;
        }

        private List<ListItem> GetMaritalStatusList()
        {
            List<ListItem> list = new List<ListItem>();
            var enumsValues = Enum.GetNames(typeof(MaritalStatus));
            foreach (var item in enumsValues)
            {
                ListItem obj = new ListItem();
                obj.Value = item;
                obj.Text = item;
                list.Add(obj);
            }
            return list;
        }

        private List<ListItem> GetSchemeCatgoryList()
        {
            List<ListItem> list = new List<ListItem>();
            list.Add(new ListItem("Former Guinness & Mahon", "Former Guinness & Mahon"));
            list.Add(new ListItem("Non Contributory", "Non Contributory"));
            list.Add(new ListItem("Contributory", "Contributory"));
            return list;
        }

        private List<ListItem> GetList()
        {
            List<ListItem> list = new List<ListItem>();
            list.Add(new ListItem("Yes", "Y"));
            list.Add(new ListItem("No", "N"));
            return list;
        }


        private List<ListItem> GetConfrimMessageList()
        {
            List<ListItem> list = new List<ListItem>();
            list.Add(new ListItem(Utility.GetAppSettingValue("correctdetails"), "true"));
            list.Add(new ListItem(Utility.GetAppSettingValue("incorrectdetails"), "false"));
            return list;
        }

        protected void rblConfirm_SelectedIndexChanged(object sender, EventArgs e)
        {
            // ShowHideButton();
        }

        private void ShowHideButton()
        {
            if (rblConfirm.SelectedIndex == -1)
                btnSubmit.Visible = false;
            else
            {
                btnSubmit.Visible = true;
                if (rblConfirm.SelectedValue == "false")
                {
                    pnlEdit.Visible = true;
                }
                else
                {
                    pnlEdit.Visible = false;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            IPWeb ipweb = new IPWeb();
            RY master = (RY)this.Master;
            try
            {
                IP_WEB ipWebData = _context.IP_WEB.Where(c => c.Username == User.Identity.Name).FirstOrDefault();

                ipWebData.PPSN = txtPPSN.Text;
                ipWebData.Surname = txtSurname.Text;
                ipWebData.Forename = txtForename.Text;
                ipWebData.Address1 = txtAddress.Text;
                ipWebData.Address2 = txtAddress2.Text;
                ipWebData.Address3 = txtAddress3.Text;
                ipWebData.Address4 = txtAddress4.Text;
                ipWebData.PhoneHome = txtHomePhone.Text;
                ipWebData.PhoneMobile = txtMobile.Text;
                ipWebData.Email = txtEmailAddress.Text;
                if (!string.IsNullOrEmpty(txtDOB.Text))
                    ipWebData.DateOfBirth = Convert.ToDateTime(txtDOB.Text);
                ipWebData.Gender = ddlGender.SelectedValue;
                ipWebData.MaritalStatus = ddlMaritalStatus.SelectedValue;
                ipWebData.ProfileLastUpdateAt = DateTime.Now;
                ipWebData.ProfileLastUpdateBy = "online";


                if (rblConfirm.SelectedValue == "false")
                {
                    ipWebData.blnCorrect = false;
                    if (ipWebData.DateEmpStart_m1 != null)
                    {
                        if (!string.IsNullOrEmpty(txtEDSCommenced.Text))
                        {
                            ipWebData.DateEmpStart_m1 = Convert.ToDateTime(txtEDSCommenced.Text);
                        }
                        if (!string.IsNullOrEmpty(txtEDSCeased.Text))
                        {
                            ipWebData.DateEmpCease_m1 = Convert.ToDateTime(txtEDSCeased.Text);
                        }
                        if (!string.IsNullOrEmpty(txtEDJScheme.Text))
                        {
                            ipWebData.DateJoinedScheme_m1 = Convert.ToDateTime(txtEDJScheme.Text);
                        }

                        ipWebData.SchemeCategory_m1 = ddlESchemeCategory.SelectedValue;

                        if (!string.IsNullOrEmpty(txtEPSal.Text))
                        {
                            ipWebData.PensionableSalary_m1 = Convert.ToDecimal(txtEPSal.Text);
                        }

                        ipWebData.TransferIn_m1 = ddlEEmployment.SelectedValue;

                        if (!string.IsNullOrEmpty(txtENRetDate.Text))
                        {
                            ipWebData.NormalRetDate_m1 = Convert.ToDateTime(txtENRetDate.Text);
                        }
                    }
                    ipWebData.DateEmpStart_m2 = null;
                    if (!string.IsNullOrEmpty(txtEDSCommenced1.Text))
                    {
                        ipWebData.DateEmpStart_m2 = Convert.ToDateTime(txtEDSCommenced1.Text);
                    }
                    ipWebData.DateEmpCease_m2 = null;
                    if (!string.IsNullOrEmpty(txtEDSCeased1.Text))
                    {
                        ipWebData.DateEmpCease_m2 = Convert.ToDateTime(txtEDSCeased1.Text);
                    }
                    ipWebData.DateJoinedScheme_m2 = null;
                    if (!string.IsNullOrEmpty(txtEDJScheme1.Text))
                    {
                        ipWebData.DateJoinedScheme_m2 = Convert.ToDateTime(txtEDJScheme1.Text);
                    }

                    ipWebData.SchemeCategory_m2 = ddlESchemeCategory1.SelectedValue;

                    ipWebData.PensionableSalary_m2 = null;
                    if (!string.IsNullOrEmpty(txtEPSal1.Text))
                    {
                        ipWebData.PensionableSalary_m2 = Convert.ToDecimal(txtEPSal1.Text);
                    }

                    ipWebData.TransferIn_m2 = ddlEEmployment1.SelectedValue;
                    ipWebData.NormalRetDate_m2 = null;
                    if (!string.IsNullOrEmpty(txtENRetDate1.Text))
                    {
                        ipWebData.NormalRetDate_m2 = Convert.ToDateTime(txtENRetDate1.Text);
                    }

                    ipWebData.MemberServiceUpdateAt = DateTime.Now;
                }
                else
                {
                    ipWebData.blnCorrect = true;
                }

                //Update data to database

                if (ipweb.Update(ipWebData))
                {
                    Messages objSuccessMessage = new Messages();
                    hdnMsg.Value = objSuccessMessage.FormatMessage(Utility.GetAppSettingValue("SuccessMessage"));
                }
                else
                {
                    Messages objUnSuccessMessage = new Messages();
                    hdnMsg.Value = objUnSuccessMessage.FormatMessage(Utility.GetAppSettingValue("UnSuccessMessage"));
                }
                LoadData();
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Occurred : " + ex.Message;
            }
        }



    }


}