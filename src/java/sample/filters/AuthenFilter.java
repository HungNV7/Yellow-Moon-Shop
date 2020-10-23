/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.dtos.UserDTO;

/**
 *
 * @author ASUS
 */
public class AuthenFilter implements Filter {

    private final List<String> admin;
    private final List<String> member;
    private final List<String> others;
    private final String HOME = "home";
    private static final boolean debug = true;
    private Logger logger = Logger.getLogger(AuthenFilter.class.getName());

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        admin = new ArrayList<String>();
        admin.add("home.jsp");
        admin.add("create.jsp");
        admin.add("search.jsp");
        admin.add("update.jsp");
        admin.add("updateDetail.jsp");
        admin.add("CreateServlet");
        admin.add("HomeServlet");
        admin.add("LogoutServlet");
        admin.add("SearchServlet");
        admin.add("SubmitUpdateServlet");
        admin.add("UpdateServlet");
        admin.add("UpdateProductServlet");

        member = new ArrayList<String>();
        member.add("home.jsp");
        member.add("information.jsp");
        member.add("search.jsp");
        member.add("trackOrder.jsp");
        member.add("cart.jsp");
        member.add("AddToCartServlet");
        member.add("CheckoutServlet");
        member.add("HomeServlet");
        member.add("LogoutServlet");
        member.add("RemoveItemServlet");
        member.add("SearchServlet");
        member.add("SubmitCartServlet");
        member.add("TrackOrderServlet");
        member.add("UpdateCartServlet");

        others = new ArrayList<String>();
        others.add("cart.jsp");
        others.add("home.jsp");
        others.add("information.jsp");
        others.add("login.jsp");
        others.add("search.jsp");
        others.add("HomeServlet");
        others.add("AddToCartServlet");
        others.add("CheckoutServlet");
        others.add("LoginServlet");
        others.add("RemoveItemServlet");
        others.add("SearchServlet");
        others.add("SubmitCartServlet");
        others.add("UpdateCartServlet");
        others.add("FacebookServlet");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
	/*
         for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
         String name = (String)en.nextElement();
         String values[] = request.getParameterValues(name);
         int n = values.length;
         StringBuffer buf = new StringBuffer();
         buf.append(name);
         buf.append("=");
         for(int i=0; i < n; i++) {
         buf.append(values[i]);
         if (i < n-1)
         buf.append(",");
         }
         log(buf.toString());
         }
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }

	// Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
	/*
         for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
         String name = (String)en.nextElement();
         Object value = request.getAttribute(name);
         log("attribute: " + name + "=" + value.toString());

         }
         */
        // For example, a filter might append something to the response.
	/*
         PrintWriter respOut = new PrintWriter(response.getWriter());
         respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            HttpSession session = req.getSession();
            String uri = req.getRequestURI();

            if (uri.contains(".jpg") || uri.contains(".png")) {
                chain.doFilter(request, response);
            } else {
                int index = uri.lastIndexOf("/");
                String resource = uri.substring(index + 1);

                if (session == null || session.getAttribute("USER") == null) {
                    if (others.contains(resource)) {
                        chain.doFilter(request, response);
                    } else {
                        res.sendRedirect(HOME);
                    }
                } else {
                    UserDTO user = (UserDTO) session.getAttribute("USER");
                    String roleID = user.getRoleID();
                    if (roleID.equals("R02")) {
                        if (member.contains(resource)) {
                            chain.doFilter(request, response);
                        } else {
                            res.sendRedirect(HOME);
                        }
                    } else if (roleID.equals("R03")) {
                        if (admin.contains(resource)) {
                            chain.doFilter(request, response);
                        } else {
                            res.sendRedirect(HOME);
                        }
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Error in AuthenFilter: " + e);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
