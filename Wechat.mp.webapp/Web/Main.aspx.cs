﻿using System;
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

        private static string ORACLE_USER_ID = "luna";
        private static string ORACLE_PASSWORD = "luna";
        private static string connString = "DATA SOURCE=ORCL_SERVER;PERSIST SECURITY INFO=True;USER ID=luna;password=luna";

        protected void Page_Load(object sender, EventArgs e)
        {
            //OracleConnection conn = new OracleConnection(connString);
            //try
            //{
            //    conn.Open();

            //    StringBuilder sqlBuilder = new StringBuilder();
            //    sqlBuilder.Append("SELECT C.CAR_ID,                  ");
            //    sqlBuilder.Append("       C.CAR_NAME,                ");
            //    sqlBuilder.Append("       C.PERSON_CNT,              ");
            //    sqlBuilder.Append("       C.LICENSE_PLATE,           ");
            //    sqlBuilder.Append("       C.DRIVER,                  ");
            //    sqlBuilder.Append("       U.USER_NAME,               ");
            //    sqlBuilder.Append("       U.TEL,                     ");
            //    sqlBuilder.Append("       C.STATUS,                  ");
            //    sqlBuilder.Append("       M.NUM                      ");
            //    sqlBuilder.Append("  FROM CARINFO C                  ");
            //    sqlBuilder.Append(" INNER JOIN USERLIST U            ");
            //    sqlBuilder.Append("    ON C.DRIVER = U.USER_ID       ");
            //    sqlBuilder.Append(" INNER JOIN MASTER M              ");
            //    sqlBuilder.Append("    ON M.ID = '01'                ");
            //    sqlBuilder.Append("   AND M.STATUS = C.STATUS        ");
            //    sqlBuilder.Append(" WHERE C.STATUS <> '3'            ");

            //    OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
            //    OracleDataAdapter oda = new OracleDataAdapter(cmd);
            //    DataTable dt = new DataTable();
            //    oda.Fill(dt);

            //    gvCarinfo.DataSource = dt;
            //    gvCarinfo.DataBind();
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            //finally
            //{
            //    conn.Close();
            //}
        }

        /// <summary>
        /// 運転者リストを取得
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetDriverList()
        {
            OracleConnection conn = new OracleConnection(connString);
            try
            {
                conn.Open();

                StringBuilder sqlBuilder = new StringBuilder();
                sqlBuilder.Append("SELECT T.USER_ID, T.USER_NAME FROM USERLIST T WHERE T.DISTINCTION = '02'");

                OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
                OracleDataAdapter oda = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                oda.Fill(dt);

                return DataTable2Json(dt);
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

        /// <summary>
        /// 車両追加
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InsertCarInfo(string carName, string personCnt, string licensePlate, string selecteDriver)
        {
            OracleConnection conn = new OracleConnection(connString);
            try
            {
                conn.Open();

                StringBuilder sqlBuilder = new StringBuilder();
                sqlBuilder.Append("insert into CARINFO          ");
                sqlBuilder.Append("  (CAR_ID,                   ");
                sqlBuilder.Append("   CAR_NAME,                 ");
                sqlBuilder.Append("   PERSON_CNT,               ");
                sqlBuilder.Append("   LICENSE_PLATE,            ");
                sqlBuilder.Append("   DRIVER,                   ");
                sqlBuilder.Append("   MAKUSER,                  ");
                sqlBuilder.Append("   MAKDT,                    ");
                sqlBuilder.Append("   UPDUSER,                  ");
                sqlBuilder.Append("   UPDDT,                    ");
                sqlBuilder.Append("   STATUS)                   ");
                sqlBuilder.Append("values                       ");
                sqlBuilder.Append("  (sq_car_id.nextval,                  ");
                sqlBuilder.Append("   :CAR_NAME,                ");
                sqlBuilder.Append("   :PERSON_CNT,              ");
                sqlBuilder.Append("   :LICENSE_PLATE,           ");
                sqlBuilder.Append("   :DRIVER,                  ");
                sqlBuilder.Append("   :MAKUSER,                 ");
                sqlBuilder.Append("   systimestamp ,                   ");
                sqlBuilder.Append("   :MAKUSER,                 ");
                sqlBuilder.Append("   systimestamp ,                   ");
                sqlBuilder.Append("   :STATUS)                 ");

                OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
                cmd.Parameters.Add("CAR_NAME", OracleType.VarChar).Value = carName;
                cmd.Parameters.Add("PERSON_CNT", OracleType.VarChar).Value = personCnt;
                cmd.Parameters.Add("LICENSE_PLATE", OracleType.VarChar).Value = licensePlate;
                cmd.Parameters.Add("DRIVER", OracleType.VarChar).Value = selecteDriver;
                cmd.Parameters.Add("MAKUSER", OracleType.VarChar).Value = "root";
                cmd.Parameters.Add("STATUS", OracleType.VarChar).Value = "1";

                cmd.ExecuteNonQuery();

                return "Success";
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

        /// <summary>
        /// LoadCarList
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string LoadCarList()
        {
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

                return DataTable2Json(dt);
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

        /// <summary>
        /// 車両追加
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string InsertReservation(string selecteCar,
            string addressFrom,
            string addressTo,
            string datetime,
            string pesvTime,
            string remark)
        {
            OracleConnection conn = new OracleConnection(connString);
            try
            {
                conn.Open();

                StringBuilder sqlBuilder = new StringBuilder();

                sqlBuilder.Append(" insert into SCHEDULE                    ");
                sqlBuilder.Append("   (EQ,                                  ");
                sqlBuilder.Append("    PLAN_CAR,                            ");
                sqlBuilder.Append("    PLAN_USER,                           ");
                sqlBuilder.Append("    FROM_LOCATION,                       ");
                sqlBuilder.Append("    FROM_TIME,                           ");
                sqlBuilder.Append("    TO_LOCATION,                         ");
                sqlBuilder.Append("    TO_TIME,                             ");
                sqlBuilder.Append("    REMARK,                             ");
                sqlBuilder.Append("    MAKUSER,                             ");
                sqlBuilder.Append("    MAKDT,                               ");
                sqlBuilder.Append("    UPDUSER,                             ");
                sqlBuilder.Append("    UPDDT,                               ");
                sqlBuilder.Append("    STATUS)                              ");
                sqlBuilder.Append(" values                                  ");
                sqlBuilder.Append("   (SQ_RESERVATION.nextval,              ");
                sqlBuilder.Append("    :PLAN_CAR,                           ");
                sqlBuilder.Append("    :PLAN_USER,                          ");
                sqlBuilder.Append("    :FROM_LOCATION,                      ");
                sqlBuilder.Append("    :FROM_TIME,                          ");
                sqlBuilder.Append("    :TO_LOCATION,                        ");
                sqlBuilder.Append("    :TO_TIME,                            ");
                sqlBuilder.Append("    :REMARK,                            ");
                sqlBuilder.Append("    :MAKUSER,                            ");
                sqlBuilder.Append("    systimestamp,                        ");
                sqlBuilder.Append("    :MAKUSER,                            ");
                sqlBuilder.Append("    systimestamp,                        ");
                sqlBuilder.Append("    :STATUS)                             ");

                OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
                cmd.Parameters.Add("PLAN_CAR", OracleType.VarChar).Value = selecteCar;
                cmd.Parameters.Add("PLAN_USER", OracleType.VarChar).Value = "root";
                cmd.Parameters.Add("FROM_LOCATION", OracleType.VarChar).Value = addressFrom;
                cmd.Parameters.Add("FROM_TIME", OracleType.Timestamp).Value =DateTime.Parse(datetime);
                cmd.Parameters.Add("TO_LOCATION", OracleType.VarChar).Value = addressTo;
                cmd.Parameters.Add("TO_TIME", OracleType.Timestamp).Value = DateTime.Parse(datetime).Add(TimeSpan.Parse(pesvTime));
                cmd.Parameters.Add("REMARK", OracleType.VarChar).Value = remark;
                cmd.Parameters.Add("MAKUSER", OracleType.VarChar).Value = "root";
                cmd.Parameters.Add("STATUS", OracleType.VarChar).Value = "1";

                cmd.ExecuteNonQuery();

                return "Success";
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

        /// <summary>
        /// SCHEDULE
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetSchedule()
        {
            OracleConnection conn = new OracleConnection(connString);
            try
            {
                conn.Open();

                StringBuilder sqlBuilder = new StringBuilder();

                sqlBuilder.Append(" SELECT S.EQ,                              ");
                sqlBuilder.Append("        S.PLAN_CAR,                        ");
                sqlBuilder.Append("        C.CAR_NAME,                        ");
                sqlBuilder.Append("        C.PERSON_CNT,                        ");
                sqlBuilder.Append("        C.LICENSE_PLATE,                        ");
                sqlBuilder.Append("        S.PLAN_USER,                       ");
                sqlBuilder.Append("        U.USER_NAME,                       ");
                sqlBuilder.Append("        S.FROM_LOCATION,                   ");
                sqlBuilder.Append("        S.FROM_TIME,                       ");
                sqlBuilder.Append("        S.TO_LOCATION,                     ");
                sqlBuilder.Append("        S.TO_TIME,                         ");
                sqlBuilder.Append("        S.REMARK,                         ");
                sqlBuilder.Append("        S.MAKUSER,                         ");
                sqlBuilder.Append("        S.MAKDT,                           ");
                sqlBuilder.Append("        S.UPDUSER,                         ");
                sqlBuilder.Append("        S.UPDDT,                           ");
                sqlBuilder.Append("        S.STATUS,                           ");
                sqlBuilder.Append("        M.NUM                           ");
                sqlBuilder.Append("   FROM SCHEDULE S                         ");
                sqlBuilder.Append("  INNER JOIN CARINFO C                     ");
                sqlBuilder.Append("     ON C.CAR_ID = S.PLAN_CAR              ");
                sqlBuilder.Append("  INNER JOIN USERLIST U                    ");
                sqlBuilder.Append("     ON U.USER_ID = S.PLAN_USER            ");
                sqlBuilder.Append("  INNER JOIN MASTER M                      ");
                sqlBuilder.Append("     ON M.ID = '03'                        ");
                sqlBuilder.Append("    AND M.STATUS = S.STATUS                ");
                sqlBuilder.Append("  WHERE S.TO_TIME > SYSTIMESTAMP           ");

                OracleCommand cmd = new OracleCommand(sqlBuilder.ToString(), conn);
                OracleDataAdapter oda = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                oda.Fill(dt);

                return DataTable2Json(dt);
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
            jsonBuilder.Append(String.IsNullOrEmpty(dt.TableName) ? "arry" : dt.TableName);
            jsonBuilder.Append("\":[");
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