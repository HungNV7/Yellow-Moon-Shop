<%-- 
    Document   : cart
    Created on : Oct 9, 2020, 4:48:15 PM
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
        <title>Cart Page</title>
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
            .pagination{
                margin-top: 2%;
            }
            h3{
                display: inline-block;
            }
            .btnCheckout{
                margin-right: 0;
                width: inherit;
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
            <c:if test="${sessionScope.CHECKOUT_FAIL != null}">
                <c:forEach var="msg" items="${sessionScope.CHECKOUT_FAIL}">
                    <div class="alert alert-danger" role="alert">              
                        ${msg}  
                    </div>
                </c:forEach>
            </c:if>
            <c:remove var="CHECKOUT_FAIL" scope="session"></c:remove>
            <c:if test="${not empty sessionScope.CHECKOUT_SUCCESS}">
                <div class="alert alert-success" role="alert">              
                    ${sessionScope.CHECKOUT_SUCCESS}  
                </div>
            </c:if>
            <c:remove var="CHECKOUT_SUCCESS" scope="session"></c:remove>
            <c:if test="${sessionScope.CART != null && sessionScope.CART.cart.size() != 0}">
                <table class="table table-striped">
                    <thead>
                        <tr>               
                            <th>No</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${sessionScope.CART.cart.values()}" varStatus="counter">   
                        <form action="updateCart">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${product.name}</td>
                                <td>
                                    <input type="number" name="txtQuantity" value="${product.quantity}" min="1"/>        
                                </td>
                                <td>${product.price}</td>
                                <td>${product.price * product.quantity}</td>
                                <td>  
                                    <input type="hidden" name="id" value="${product.id}"/>
                                    <input class="btn btn-secondary" type="submit" value="Update"/>
                                </td>
                                <td>
                                    <!-- Button trigger modal -->
                                    <a type="button" class="btn" data-toggle="modal" data-target="#Remove${product.id}">
                                        X
                                    </a>

                                    <!-- Modal -->
                                    <div class="modal fade" id="Remove${product.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Remove Item</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    Do you really want to remove this item?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <a class="btn btn-primary" href="removeItem?id=${product.id}">Remove</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </tr>
                        </form>                      
                    </c:forEach>
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-6">
                        <h3>Total: ${sessionScope.CART.total} VND</h3>
                    </div>
                    <div class="col-3"></div>
                    <div class="col-3">
                        <a class="btn btn-info btnCheckout" href="checkout">Check-out</a>
                    </div>
                </div>   
            </c:if>
            <c:if test="${sessionScope.CART == null || sessionScope.CART.cart.size() == 0}">
                <c:if test="${not empty sessionScope.ORDERID  && sessionScope.USER != null}">
                    <h2>Your orderID: ${sessionScope.ORDERID}</h2>      
                </c:if>
                <c:if test="${empty sessionScope.ORDERID}">
                    <h2>Your cart is empty.</h2>      
                </c:if>
            </c:if>
        </div>
    </body>
</html>
