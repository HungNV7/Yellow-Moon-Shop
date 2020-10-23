<%-- 
    Document   : information
    Created on : Oct 11, 2020, 9:25:15 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
        <title>Information Page</title>
        <style>
            body{
                background-color: whitesmoke;
            }
            h2{
                text-align: center;
            }
            .container-fluid{
                margin-top: 5%;
            }
            .navbar{
                overflow: hidden;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 100;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                <a class="navbar-brand" href="home">Yellow Moon</a>
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link" href="home">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <c:if test="${sessionScope.USER != null && sessionScope.USER.roleID == 'R03'}">  
                        <li class="nav-item">
                            <a class="nav-link" href="create.jsp">Create new product</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="update">Update product</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.USER == null || sessionScope.USER.roleID != 'R03'}">  
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">View Cart</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.USER != null && sessionScope.USER.roleID == 'R02'}">  
                        <li class="nav-item">
                            <a class="nav-link" href="trackOrder.jsp">Track order</a>
                        </li>
                    </c:if>
                </ul>
                <c:if test="${sessionScope.USER != null}">  
                    <a href="logout" class="btn btn-outline-success my-2 my-sm-0" type="submit">Logout</a>
                </c:if>
                <c:if test="${sessionScope.USER == null}">  
                    <a href="login.jsp" class="btn btn-outline-success my-2 my-sm-0" type="submit">Login</a>
                </c:if>
            </div>
        </nav>

        <div class="container-fluid main row">
            <div class="col-3"></div>
            <div class="col-6">
                <h2>CUSTOMER'S INFORMATION</h2>
                <form action="submitCart">
                    <div class="form-group">
                        <label>Name</label>
                        <c:if test="${sessionScope.USER != null}">
                            <input type="text" class="form-control" placeholder="Enter name"  name="txtName" value="${sessionScope.CART.name}" style="border: 1px solid;" disabled="true"></input>
                            <input type="hidden" name="txtName" value="${sessionScope.CART.name}"/>
                        </c:if>
                        <c:if test="${sessionScope.USER == null}">
                            <input type="text" class="form-control" placeholder="Enter name"  name="txtName" value="${sessionScope.CART.name}" style="border: 1px solid;"></input>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" class="form-control" placeholder="Enter phone"  name="txtPhone" value="${sessionScope.CART.phone}" style="border: 1px solid;"></input>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" placeholder="Enter address"  name="txtAddress" value="${sessionScope.CART.address}" style="border: 1px solid;"></input>
                    </div>
                    <c:if test="${not empty sessionScope.SUBMIT_CART_FAIL}">
                        <font color="red"><small>${sessionScope.SUBMIT_CART_FAIL}</small></font> 
                        </c:if>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </div>             
        </div>
        <div class="col-3"></div>
    </body>
</html>
