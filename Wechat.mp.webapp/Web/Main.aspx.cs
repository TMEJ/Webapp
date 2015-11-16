using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Wechat.mp.webapp.Web
{
    public partial class Main : System.Web.UI.Page
    {

        private string ORACLE_USER_ID = "luna";
        private string ORACLE_PASSWORD = "luna";
        protected void Page_Load(object sender, EventArgs e)
        {
            string connString = "DATA SOURCE=ORCL_SERVER;PERSIST SECURITY INFO=True;USER ID=luna;password=luna";
            OracleConnection conn = new OracleConnection(connString);
            try
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("select * from carinfo", conn);
                OracleDataAdapter oda = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                oda.Fill(dt);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}