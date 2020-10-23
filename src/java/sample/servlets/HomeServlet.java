/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CategoryDAO;
import sample.daos.ProductDAO;
import sample.dtos.CategoryDTO;
import sample.dtos.ProductDTO;
import sample.utilities.APIWrapper;

/**
 *
 * @author ASUS
 */
public class HomeServlet extends HttpServlet {

    private final String SUCCESS = "home.jsp";
    private Logger logger = Logger.getLogger(HomeServlet.class.getName());

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        try {
            HttpSession session = request.getSession();
            List<CategoryDTO> list = (List<CategoryDTO>) session.getAttribute("CATEGORY");
            if (list == null) {
                CategoryDAO categoryDAO = new CategoryDAO();
                list = categoryDAO.getListCategory();
                session.setAttribute("CATEGORY", list);
            }
            String page = request.getParameter("page");
            String other = request.getParameter("other");
            if (page == null) {
                page = "1";
            }
            int index = Integer.parseInt(page);
            ProductDAO productDAO = new ProductDAO();
            int count = (int) Math.ceil((double) productDAO.count() / 4);
            session.setAttribute("COUNT", count);
            if (other != null) {
                if (other.equals("prev")) {
                    index = (index - 1) < 1 ? 1 : index - 1;
                } else {
                    index = (index + 1) > count ? count : index + 1;
                }
            }
            request.setAttribute("page", index);

            List<ProductDTO> listProduct = productDAO.getActiveProducts((index - 1) * 4);
            if (listProduct.size() != 0) {
                session.setAttribute("LIST_PRODUCTS", listProduct);
            }
        } catch (Exception e) {
            logger.error("Error in HomeServlet: " + e);
        } finally {
           request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
