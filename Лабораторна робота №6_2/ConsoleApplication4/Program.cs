using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;

namespace ConsoleApplication4
{
    class Program
    {
        static void Main(string[] args)
        {
            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString = @"Data Source=XARDAS-ПК\SQLEXPRESS;Initial Catalog=LAB6_2;" + "Integrated Security=SSPI;Pooling=False";
                try
                {
                    cn.Open();
                    string sqlQuery = "SELECT * FROM Person WHERE Name=@username";
                    SqlCommand sqlCmd = new SqlCommand(sqlQuery, cn);
                    sqlCmd.Parameters.Add("@username", SqlDbType.VarChar).Value = Console.ReadLine();
                    using (SqlDataReader rdr = sqlCmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            string mystring = "";
                            for (int i = 0; i < rdr.FieldCount; i++) 
                            {
                                mystring += rdr[i] + " ";  
                            }
                            Console.WriteLine(mystring);
                        }
                    }
                }
                catch(Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                finally
                {
                    cn.Close();
                }
                Console.ReadKey();
            }
        }
    }
}
