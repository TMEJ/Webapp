using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.OracleClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
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

                StringBuilder sqlBuilder = new StringBuilder();
                sqlBuilder.Append("SELECT C.CAR_ID,                  ");
                sqlBuilder.Append("       C.CAR_NAME,                ");
                sqlBuilder.Append("       C.PERSON_CNT,              ");
                sqlBuilder.Append("       C.LICENSE_PLATE,           ");
                sqlBuilder.Append("       C.DRIVER,                  ");
                sqlBuilder.Append("       U.USER_NAME,               ");
                sqlBuilder.Append("       U.TEL,                     ");
                sqlBuilder.Append("       C.STATUS,                  ");
                sqlBuilder.Append("       M.NUM                      ");
                sqlBuilder.Append("  FROM CARINFO C                  ");
                sqlBuilder.Append(" INNER JOIN USERLIST U            ");
                sqlBuilder.Append("    ON C.DRIVER = U.USER_ID       ");
                sqlBuilder.Append(" INNER JOIN MASTER M              ");
                sqlBuilder.Append("    ON M.ID = '01'                ");
                sqlBuilder.Append("   AND M.STATUS = C.STATUS        ");
                sqlBuilder.Append(" WHERE C.STATUS <> '3'            ");

                OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
                OracleDataAdapter oda = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                oda.Fill(dt);

                gvCarinfo.DataSource = dt;
                gvCarinfo.DataBind();
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

        [WebMethod]
        public static string getXXX() { return "Hello Ajax!"; }

        #region dataTable转换成Json格式
        /// <summary>  
        /// dataTable转换成Json格式  
        /// </summary>  
        /// <param name="dt"></param>  
        /// <returns></returns>  
        public static string DataTable2Json(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append(dt.TableName);
            jsonBuilder.Append("\":[");
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        #endregion dataTable转换成Json格式
    }
}