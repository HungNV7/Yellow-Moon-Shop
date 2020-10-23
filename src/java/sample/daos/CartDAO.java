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
import sample.utilities.DBUtils;
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;
import sample.dtos.ProductDTO;

/**
 *
 * @author ASUS
 */
public class CartDAO {

    private Logger logger = Logger.getLogger(CartDAO.class.getName());

    public void add(CartDTO cart) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblOrder(orderID, userID, total, date, name, address, phoneNumber, paymentMethod, paymentStatus)"
                        + " VALUES(?,?,?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, cart.getId());
                stm.setString(2, cart.getUserID());
                stm.setInt(3, cart.getTotal());
                stm.setDate(4, cart.getDate());
                stm.setString(5, cart.getName());
                stm.setString(6, cart.getAddress());
                stm.setString(7, cart.getPhone());
                stm.setString(8, cart.getPaymentMethod());
                stm.setInt(9, cart.getPaymentStatus());

                stm.executeUpdate();

                for (ProductDTO product : cart.getCart().values()) {
                    sql = "INSERT INTO tblOrderDetail(productID, price, quantity, orderID) VALUES (?,?,?,?)";
                    stm = conn.prepareStatement(sql);
                    stm.setString(1, product.getId());
                    stm.setInt(2, product.getPrice());
                    stm.setInt(3, product.getQuantity());
                    stm.setString(4, cart.getId());
                    stm.executeUpdate();
                }
            }
        } catch (Exception e) {
            logger.error("Error in CartDAO_add: " + e);
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

    public CartDTO get(String id) throws SQLException {
        CartDTO cart = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID, total, date, name, address, phoneNumber, paymentMethod, paymentStatus FROM tblOrder WHERE orderID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();

                if (rs.next()) {
                    cart = new CartDTO();
                    cart.setId(id);
                    cart.setUserID(rs.getString("userID"));
                    cart.setTotal(rs.getInt("total"));
                    cart.setDate(rs.getDate("date"));
                    cart.setName(rs.getString("name"));
                    cart.setAddress(rs.getString("address"));
                    cart.setPhone(rs.getString("phoneNumber"));
                    cart.setPaymentMethod(rs.getString("paymentMethod"));
                    cart.setPaymentStatus(rs.getInt("paymentStatus"));
                }

                sql = "SELECT A. productID, B.name, A.price, A.quantity\n"
                        + "FROM tblOrderDetail A, tblProduct B\n"
                        + "WHERE A.productID = B.productID AND A.orderID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                while(rs.next()){
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    
                    cart.getCart().put(productID, new ProductDTO(id, name, price, quantity));
                }
            }
        } catch (Exception e) {
            logger.error("Error in CartDAO_get: " + e);
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
        return cart;
    }
    
    public boolean checkID(String id, String userID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql = "SELECT userID FROM tblOrder WHERE orderID = ? AND userID IS NOT NULL AND userID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                stm.setString(2, userID);
                rs = stm.executeQuery();
                if(rs.next()){
                    check= true;
                }
            }
        } catch (Exception e) {
            logger.error("Error in CartDAO_checkID: " + e);
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
        return check;
    }
}
