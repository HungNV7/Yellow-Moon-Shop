/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.servlets;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.ProductDAO;
import sample.dtos.CategoryDTO;
import sample.dtos.ErrorProductDTO;
import sample.dtos.ProductDTO;

/**
 *
 * @author ASUS
 */
public class CreateServlet extends HttpServlet {

    private final String SUCCESS = "home";
    private final String ERROR = "create.jsp";
    private Logger logger = Logger.getLogger(CreateServlet.class.getName());

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
            String linkImage = request.getParameter("txtImage");
            String description = request.getParameter("txtDescription");
            String price = request.getParameter("txtPrice");
            String quantity = request.getParameter("txtQuantity");
            String txtCreateDate = request.getParameter("txtCreateDate");
            String txtExpirateDate = request.getParameter("txtExpirateDate");
            String category = request.getParameter("txtCategory");

            ErrorProductDTO error = new ErrorProductDTO();
            boolean check = true;

            if (name.isEmpty()) {
                error.setErrorName("Name is required!");
                check = false;
            }
            if (description.isEmpty()) {
                error.setErrorDescription("Description is required!");
                check = false;
            }
            if (linkImage.isEmpty()) {
                error.setErrorLinkImage("Image is required!");
                check = false;
            }
            if (linkImage.lastIndexOf(".png") <= 0 && linkImage.lastIndexOf(".jpg") <= 0) {
                error.setErrorLinkImage("Link image is not valid!");
                check = false;
            }
            if (price.isEmpty()) {
                error.setErrorPrice("Price is required!");
                check = false;
            }
            if (!price.matches("[0-9]+") || price.matches("[0]+")) {
                error.setErrorPrice("Price must be positive number!");
                check = false;
            }
            if (quantity.isEmpty()) {
                error.setErrorQuantity("Quantity is required!");
                check = false;
            }
            if (!quantity.matches("[0-9]+") || quantity.matches("[0]+")) {
                error.setErrorQuantity("Quantity must be positive number");
                check = false;
            }
            if (txtCreateDate.isEmpty()) {
                error.setErrorCreateDate("Create Date is required!");
                check = false;
            }
            if (txtExpirateDate.isEmpty()) {
                error.setErrorExpirateDate("Expirate Date is required!");
                check = false;
            }
            Date creatDate = null;
            Date expirateDate = null;
            if (!txtCreateDate.isEmpty() && !txtExpirateDate.isEmpty()) {
                creatDate = Date.valueOf(txtCreateDate);
                expirateDate = Date.valueOf(txtExpirateDate);
                if (expirateDate.before(creatDate)) {
                    error.setErrorExpirateDate("Expirated date must be after created Date");
                    check = false;
                }
            }
            HttpSession session = request.getSession();
            if (check) {
                List<CategoryDTO> list = (List<CategoryDTO>) session.getAttribute("CATEGORY");
                String id = "";
                for (CategoryDTO categoryDTO : list) {
                    if (categoryDTO.getName().equals(category)) {
                        id = categoryDTO.getId();
                    }
                }

                ProductDTO productDTO = new ProductDTO("", name, description, linkImage, id, creatDate, expirateDate, Integer.parseInt(price), Integer.parseInt(quantity), 1);
                ProductDAO productDAO = new ProductDAO();
                productDAO.create(productDTO);
                url = SUCCESS;
            } else {
                session.setAttribute("CREATE_FAIL", error);
            }

        } catch (Exception e) {
            logger.error("Error in CreateServlet: " + e);
        } finally {
            response.sendRedirect(url);
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
