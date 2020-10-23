<%-- 
    Document   : trackOrder
    Created on : Oct 12, 2020, 4:49:40 PM
    Author     : ASUS
--%>

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
        <title>Track Order Page</title>
        <style>
            body{
                background-color: whitesmoke;
            }
            h2{
                text-align: center;
            }
            .container{
                margin-top: 5%;
            }
            .navbar{
                overflow: hidden;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 100;
            }
            #expirateDate{
                padding-left: 15%;
            }
            .pagination{
                margin-top: 2%;
            }
            .order{
                margin-top: 2%;
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

        <div class="container">
            <h2>Information of order</h2>
            <form action="trackOrder" method="POST">
                <div class="row">
                    <div class="col-2"></div>
                    <div class="col-7">
                        <input type="text" class="form-control" name="txtID" value="${param.txtID}" style="border: 1px solid;">
                    </div>
                    <div class="col-1">
                        <input type="submit" value="Search" class="btn btn-primary"/>
                    </div>
                    <div class="col-2"></div>
                </div>
            </form>
            <c:if test="${sessionScope.TRACK_ORDER != null}">
                <div class="alert alert-secondary order" role="alert">
                    <div class="row">
                        <div class="col-6">
                            <h5 class="alert-heading">Customer Name: ${sessionScope.USER.name}</h5>
                            <h5 class="alert-heading">Order Date: ${sessionScope.TRACK_ORDER.date}</h5>
                            <h5 class="alert-heading">Payment Method: ${sessionScope.TRACK_ORDER.paymentMethod}</h5>
                            <h5 class="alert-heading">Phone: ${sessionScope.TRACK_ORDER.phone}</h5>
                        </div>
                        <div class="col-6">
                            <h5></h5>
                            <h5 class="alert-heading">Order ID: ${sessionScope.TRACK_ORDER.id}</h5>                   
                            <c:if test="${sessionScope.TRACK_ORDER.paymentStatus == 3}">
                                <h5 class="alert-heading">Payment Status: Done</h5>
                            </c:if>
                            <c:if test="${sessionScope.TRACK_ORDER.paymentStatus == 4}">
                                <h5 class="alert-heading">Payment Status: Not yet</h5>
                            </c:if>
                            <h5 class="alert-heading">Address: ${sessionScope.TRACK_ORDER.address}</h5>
                        </div>
                    </div>
                    <hr>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${sessionScope.TRACK_ORDER.cart.values()}" varStatus="count">
                                <tr>
                                    <td>${count.count}</td>
                                    <td>${product.name}</td>
                                    <td>${product.price}</td>
                                    <td>${product.quantity}</td>
                                    <td>${product.price * product.quantity}</td>
                                </tr>
                            </c:forEach>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>Total: </td>
                        <td>${sessionScope.TRACK_ORDER.total} VND</td>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.TRACK_FAIL}">
                <br>
                <h2>${sessionScope.TRACK_FAIL}</h2>
            </c:if>
            <c:remove var="TRACK_FAIL" scope="session"></c:remove>
        </div>         
    </body>
</html>
