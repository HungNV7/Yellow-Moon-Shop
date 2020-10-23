
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.utilities;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author ASUS
 */
public class DBUtils {
    public static Connection getConnection() throws NamingException, SQLException{
        Context context = new InitialContext();
        Context tomcatCtx = (Context) context.lookup("java:/comp/env");
        DataSource ds = (DataSource) tomcatCtx.lookup("YellowMoonShop");
        
        return ds.getConnection();
    }
}
