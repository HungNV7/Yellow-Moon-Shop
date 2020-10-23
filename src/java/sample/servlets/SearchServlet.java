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
import sample.daos.ProductDAO;
import sample.dtos.ProductDTO;

/**
 *
 * @author ASUS
 */
public class SearchServlet extends HttpServlet {

    private final String SUCCESS = "search.jsp";
    private final String ERROR = "error.jsp";
    private Logger logger = Logger.getLogger(SearchServlet.class.getName());

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
        String url = ERROR;
        try {
            String name = request.getParameter("txtName");
            String rangePrice = request.getParameter("txtPrice");
            String category = request.getParameter("txtCategory");

            String[] str = rangePrice.split(" - ");
            int begin = Integer.parseInt(str[0]);
            int end = Integer.parseInt(str[1]);

            String page = request.getParameter("page");
            String other = request.getParameter("other");
            if (page == null) {
                page = "1";
            }
            int index = Integer.parseInt(page);
            HttpSession session = request.getSession();
            ProductDAO productDAO = new ProductDAO();
            int count = (int) Math.ceil((double) productDAO.count(name, category, begin, end)/ 4);
            session.setAttribute("COUNT_SEARCH", count);
            if (other != null) {
                if (other.equals("prev")) {
                    index = (index - 1) < 1 ? 1 : index - 1;
                } else {
                    index = (index + 1) > count ? count : index + 1;
                }
            }
            request.setAttribute("page", index);
            List<ProductDTO> list = productDAO.search(name, category, begin, end, (index - 1)*4);

            session.setAttribute("SEARCH_PRODUCT", list);
            url = SUCCESS;
        } catch (Exception e) {
            logger.error("Error in SearchServlet: " + e);
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
