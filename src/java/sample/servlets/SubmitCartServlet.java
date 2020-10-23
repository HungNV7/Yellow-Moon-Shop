/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.servlets;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CartDAO;
import sample.daos.ProductDAO;
import sample.dtos.CartDTO;
import sample.dtos.ProductDTO;

/**
 *
 * @author ASUS
 */
public class SubmitCartServlet extends HttpServlet {

    private final String SUCCESS = "cart.jsp";
    private final String ERROR = "information.jsp";
    private Logger logger = Logger.getLogger(SubmitCartServlet.class.getName());

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
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");

            String msg = "";
            if (!phone.matches("[\\d]+")) {
                msg = "Phone is not valid!";
            }
            if (name.isEmpty() || phone.isEmpty() || address.isEmpty()) {
                msg = "All filed is required!";
            }
            
            HttpSession session = request.getSession();
            if (msg.equals("")) {
                CartDTO cart = (CartDTO) session.getAttribute("CART");        
                if (cart != null && cart.getCart().size() != 0) {
                    long id = System.currentTimeMillis();
                    cart.setId(id + "");
                    Date date = new Date(id);
                    cart.setDate(date);
                    ProductDAO productDAO = new ProductDAO();
                    for (ProductDTO product : cart.getCart().values()) {
                        productDAO.updateQuantity(product);
                    }
                    cart.setName(name);
                    cart.setPhone(phone);
                    cart.setAddress(address);
                    CartDAO cartDAO = new CartDAO();
                    cartDAO.add(cart);
                    session.setAttribute("CHECKOUT_SUCCESS", "Check out successfully!");
                    session.setAttribute("ORDERID", id);
                    session.removeAttribute("CART");
                    url = SUCCESS;
                }
            } else {
                session.setAttribute("SUBMIT_CART_FAIL", msg);
            }
        } catch (Exception e) {
            logger.error("Error in SubmitCartServlet: " + e);
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
