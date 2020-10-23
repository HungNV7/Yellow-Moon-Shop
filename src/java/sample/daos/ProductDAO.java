/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import sample.dtos.ProductDTO;
import sample.utilities.DBUtils;

/**
 *
 * @author ASUS
 */
public class ProductDAO {

    private Logger logger = Logger.getLogger(ProductDAO.class.getName());

    public void create(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblProduct(name, image, description, price, quantity, createDate, expirationDate, categoryID, status)"
                    + "VALUES(?,?,?,?,?,?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, product.getName());
            stm.setString(2, product.getLinkImage());
            stm.setString(3, product.getDescription());
            stm.setInt(4, product.getPrice());
            stm.setInt(5, product.getQuantity());
            stm.setDate(6, product.getCreateDate());
            stm.setDate(7, product.getExpirateDate());
            stm.setString(8, product.getCategoryID());
            stm.setInt(9, product.getStatus());
            stm.executeUpdate();
        } catch (Exception e) {
            logger.error("Error in ProductDAO_create: " + e);
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

    public List<ProductDTO> getActiveProducts(int index) throws SQLException {
        List<ProductDTO> list = new ArrayList<ProductDTO>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT productID, name, image, description, price, quantity, createDate, expirationDate, categoryID, status FROM tblProduct"
                    + " WHERE status = 1 AND quantity > 0 AND expirationDate >= CAST(GETDATE() AS DATE) ORDER BY expirationDate DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, index);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("productID");
                String name = rs.getNString("name");
                String image = rs.getNString("image");
                String description = rs.getNString("description");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");
                Date createDate = rs.getDate("createDate");
                Date expirateDate = rs.getDate("expirationDate");
                String categoryID = rs.getNString("categoryID");
                int status = rs.getInt("status");

                list.add(new ProductDTO(id, name, description, image, categoryID, createDate, expirateDate, price, quantity, status));
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_getProduct: " + e);
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
        return list;
    }

    public int count() throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT COUNT(productID) as TOTAL FROM tblProduct WHERE status = 1 AND quantity > 0 AND expirationDate >= CAST(GETDATE() AS DATE)";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("TOTAL");
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_count: " + e);
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
        return result;
    }

    public int countAll() throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT COUNT(productID) as TOTAL FROM tblProduct";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("TOTAL");
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_count: " + e);
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
        return result;
    }

    public int count(String search, String category, int begin, int end) throws SQLException {
        int result = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT COUNT(productID) AS TOTAL\n"
                    + "FROM tblProduct A, tblCategory B\n"
                    + "WHERE A.categoryID = B.categoryID AND status = 1 AND quantity > 0 AND expirationDate >= CAST(GETDATE() AS DATE) AND A.name LIKE ? AND B.name = ? AND price BETWEEN ? AND ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            stm.setString(2, category);
            stm.setInt(3, begin);
            stm.setInt(4, end);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("TOTAL");
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_count_search: " + e);
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
        return result;
    }

    public List<ProductDTO> search(String search, String category, int begin, int end, int index) throws SQLException {
        List<ProductDTO> list = new ArrayList<ProductDTO>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT productID, A.name, image, description, price, quantity, createDate, expirationDate, A.categoryID \n"
                    + "FROM tblProduct A, tblCategory B\n"
                    + "WHERE A.categoryID = B.categoryID AND A.name LIKE ? AND status = 1 AND quantity > 0 AND expirationDate >= CAST(GETDATE() AS DATE) AND B.name = ? AND price BETWEEN ? AND ?"
                    + " ORDER BY expirationDate DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            stm.setString(2, category);
            stm.setInt(3, begin);
            stm.setInt(4, end);
            stm.setInt(5, index);

            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("productID");
                String name = rs.getNString("name");
                String image = rs.getNString("image");
                String description = rs.getNString("description");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");
                Date createDate = rs.getDate("createDate");
                Date expirateDate = rs.getDate("expirationDate");
                String categoryID = rs.getString("categoryID");
                list.add(new ProductDTO(id, name, description, image, categoryID, createDate, expirateDate, price, quantity, 1));
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_search: " + e);
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
        return list;
    }

    public List<ProductDTO> getAll(int index) throws SQLException {
        List<ProductDTO> list = new ArrayList<ProductDTO>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT productID, name, image, description, price, quantity, createDate, expirationDate, categoryID, status FROM tblProduct"
                    + " ORDER BY expirationDate DESC OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, index);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("productID");
                String name = rs.getNString("name");
                String image = rs.getNString("image");
                String description = rs.getNString("description");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");
                Date createDate = rs.getDate("createDate");
                Date expirateDate = rs.getDate("expirationDate");
                String categoryID = rs.getNString("categoryID");
                int status = rs.getInt("status");
                list.add(new ProductDTO(id, name, description, image, categoryID, createDate, expirateDate, price, quantity, status));
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_getAll: " + e);
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
        return list;
    }

    public ProductDTO getProduct(String id) throws SQLException {
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT name, image, description, price, quantity, createDate, expirationDate, categoryID, status FROM tblProduct"
                    + " WHERE productID LIKE ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                String name = rs.getNString("name");
                String image = rs.getNString("image");
                String description = rs.getNString("description");
                int price = rs.getInt("price");
                int quantity = rs.getInt("quantity");
                Date createDate = rs.getDate("createDate");
                Date expirateDate = rs.getDate("expirationDate");
                String categoryID = rs.getNString("categoryID");
                int status = rs.getInt("status");

                product = new ProductDTO(id, name, description, image, categoryID, createDate, expirateDate, price, quantity, status);
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_getProduct: " + e);
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
        return product;
    }

    public void update(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblProduct\n"
                        + "SET name = ?, image = ?, description = ?, price = ?, quantity = ?, createDate = ?, expirationDate = ?, categoryID = ?, status = ? \n"
                        + "WHERE productID = ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, product.getName());
                stm.setString(2, product.getLinkImage());
                stm.setString(3, product.getDescription());
                stm.setInt(4, product.getPrice());
                stm.setInt(5, product.getQuantity());
                stm.setDate(6, product.getCreateDate());
                stm.setDate(7, product.getExpirateDate());
                stm.setString(8, product.getCategoryID());
                stm.setInt(9, product.getStatus());
                stm.setString(10, product.getId());

                stm.executeUpdate();
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_update: " + e);
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

    public String checkQuantity(ProductDTO product) throws SQLException {
        String result = "";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT quantity FROM tblProduct WHERE productID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, product.getId());

                int quantity = 0;
                rs = stm.executeQuery();
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }

                if (product.getQuantity() > quantity) {
                    result = "*" + product.getName() + " has only " + quantity+ " in store";
                }
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_checkQuantity: " + e);
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
        return result;
    }

    public void updateQuantity(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblProduct\n"
                        + "SET quantity = quantity - ?\n"
                        + "WHERE productID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, product.getQuantity());
                stm.setString(2, product.getId());
                
                stm.executeUpdate();
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO_updateQuantity: " + e);
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
