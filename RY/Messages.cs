using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace APT2012.RY
{
    public class Messages
    {
        public DateTime date { get; set; }
        public TimeSpan time { get; set; }
        public string by_whom { get; set; }
        public string PPSN { get; set; }
        public string Surname { get; set; }
        public string Forename { get; set; }

        public string FormatMessage(string message)
        {
            var properties = this.GetType().GetProperties().Where(p => p.GetValue(this, null) != null);

            foreach (var property in properties)
            {
                string value = string.Empty;
                if (property.GetValue(this, null) != null)
                {
                    if (property.PropertyType == typeof(System.DateTime))
                    {
                        if (Convert.ToDateTime(property.GetValue(this, null)) != DateTime.MinValue)
                            value = Convert.ToDateTime(property.GetValue(this, null)).ToString(@"dd/MM/yyyy");
                    }
                    else if (property.PropertyType == typeof(System.TimeSpan))
                    {
                        if (property.GetValue(this, null) != null && ((TimeSpan)property.GetValue(this, null)) != TimeSpan.Zero)
                            value = ((TimeSpan)property.GetValue(this, null)).ToString(@"hh\:mm");
                    }
                    else
                    {
                        //message.Replace("#" + property.Name, property.GetValue(this, null).ToString());
                        //Modifed by Tom Richardson 16-12-13
                        value = property.GetValue(this, null).ToString();
                    }
                }

                message = message.Replace("#" + property.Name, value);
            }
            return message;
        }
    }
}