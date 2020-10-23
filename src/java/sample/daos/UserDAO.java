/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import sample.dtos.UserDTO;
import sample.utilities.DBUtils;
/**
 *
 * @author ASUS
 */
public class UserDAO {
    private Logger logger = Logger.getLogger(UserDAO.class.getName());
    
    public UserDTO checkLogin(String userID, String password) throws SQLException{
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;   
        try {
            conn = DBUtils.getConnection();

            String sql = "SELECT name, roleID, phone, address FROM tblUser WHERE userID = ? AND password = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userID);
            stm.setString(2, password);
            
            rs = stm.executeQuery();
            
            if(rs.next()){
                String name = rs.getString("name");
                String roleID = rs.getString("roleID");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                result = new UserDTO(userID, password, name, roleID, phone, address);
            }
        } catch (Exception e) {
            logger.error("Error in UserDAO: " + e);
        }finally{
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(conn != null){
                conn.close();
            }
        }
        return result;
    }
    
    public UserDTO checkLogin(String userID) throws SQLException{
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql = "SELECT name, roleID FROM tblUser WHERE userID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                
                rs = stm.executeQuery();
                if(rs.next()){
                    String name = rs.getString("name");
                    String roleID = rs.getString("roleID");
                    
                    user = new UserDTO(userID, "", name, roleID, "", "");
                }
            }
        } catch (Exception e) {
            logger.error("Error in UserDAO_checkLoginFB: " + e);
        }finally{
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(conn != null){
                conn.close();
            }
        }
        return user;
    }
    
    public void insert(UserDTO user) throws SQLException{
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql = "INSERT INTO tblUser(userID, name, roleID) VALUES(?,?,'R02')";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getUserID());
                stm.setString(2, user.getName());
                
                stm.executeUpdate();
            }
        } catch (Exception e) {
            logger.error("Error in UserDAO_insert: " + e);
        }finally{
            if(rs != null){
                rs.close();
            }
            if(stm != null){
                stm.close();
            }
            if(conn != null){
                conn.close();
            }
        }
    }
}
