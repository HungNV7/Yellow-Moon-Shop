/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import sample.dtos.CategoryDTO;
import sample.utilities.DBUtils;

/**
 *
 * @author ASUS
 */
public class CategoryDAO {

    private Logger logger = Logger.getLogger(CategoryDAO.class.getName());

    public List<CategoryDTO> getListCategory() throws SQLException {
        List<CategoryDTO> list = new ArrayList<CategoryDTO>();
       Connection conn = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            stm = conn.createStatement();
            String sql = "SELECT categoryID, name FROM tblCategory";

            rs = stm.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("categoryID");
                String name = rs.getString("name");
                list.add(new CategoryDTO(id, name));
            }
        } catch (Exception e) {
            logger.error("Error in ProductDAO: " + e);
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

}
