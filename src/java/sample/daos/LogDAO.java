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
import sample.dtos.LogDTO;
import sample.utilities.DBUtils;

/**
 *
 * @author ASUS
 */
public class LogDAO {

    private Logger logger = Logger.getLogger(LogDAO.class.getName());

    public void insert(LogDTO log) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblLog(userID, productID, date) VALUES(?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, log.getUserId());
                stm.setString(2, log.getProductId());
                stm.setDate(3, log.getDate());

                stm.executeUpdate();
            }
        } catch (Exception e) {
            logger.error("Error in LogDAO_insert: " + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public String getID(String productID) throws SQLException {
        String id = "";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT logID FROM tblLog WHERE productID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, productID);
                rs = stm.executeQuery();
                if(rs.next()){
                    id = rs.getString("logID");
                }
            }
        } catch (Exception e) {
            logger.error("Error in LogDAO_getID: " + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return id;
    }
    
    public void update(LogDTO log) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblLog SET userID = ?, date = ? WHERE logID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, log.getUserId());
                stm.setDate(2, log.getDate());
                stm.executeUpdate();
            }
        } catch (Exception e) {
            logger.error("Error in LogDAO_update: " + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
