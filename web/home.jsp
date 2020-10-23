<%-- 
    Document   : home
    Created on : Oct 7, 2020, 4:44:00 AM
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
        <title>Home Page</title>
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
            <c:if test="${sessionScope.USER != null}">  
                <h2>Welcome ${sessionScope.USER.name}</h2>
            </c:if>
            <form action="search" method="POST">
                <div class="row">
                    <div class="col-5" input-group>
                        <input type="text" class="form-control" name="txtName" value="${param.txtName}" style="border: 1px solid;">
                    </div>
                    <div class="input-group col-3">
                        <select name="txtPrice" class="form-control" style="border: 1px solid;">
                            <option value="0 - 100000" >0 - 100000VND</option>
                            <option value="100000 - 150000">100000 - 150000VND</option>
                            <option value="150000 - 200000">150000 - 200000VND</option>
                            <option value="200000 - 500000">200000 - 500000VND</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <div class="form-group">
                            <select name="txtCategory" class="form-control" style="border: 1px solid;">
                                <c:forEach var="category" items="${sessionScope.CATEGORY}"> 
                                    <option value="${category.name}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-1">
                        <input type="submit" value="Search" class="btn btn-primary"/>
                    </div>
                </div>
            </form>
            <c:if test="${not empty sessionScope.MESSAGE_ADD}">
                <div class="alert alert-success" role="alert">              
                    ${sessionScope.MESSAGE_ADD}  
                </div>
            </c:if>
            <c:remove var="MESSAGE_ADD" scope="session"></c:remove>
                <div class="row">           
                <c:forEach var="product" items="${sessionScope.LIST_PRODUCTS}">
                    <div class="col-6">
                        <div class="card">
                            <img src="Image/${product.linkImage}" class="card-img-top" alt="..." height="400vh">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.description}</p>
                                <p class="card-text" style="font-weight: bold">Price: ${product.price} VND</p>
                                <p><span>Create Date: ${product.createDate}</span><span id="expirateDate">Expirate Date: ${product.expirateDate}</span></p>
                                <c:if test="${sessionScope.USER.roleID != 'R03'}">
                                    <a href="addToCart?id=${product.id}" class="btn btn-primary">Add to Cart</a>
                                </c:if>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${sessionScope.LIST_PRODUCTS.size() != 0}">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="home?page=${requestScope.page}&other=prev" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:if test="${sessionScope.COUNT != null}">
                            <c:forEach begin="1" end="${sessionScope.COUNT}" varStatus="count">
                                <li class="page-item"><a class="page-link" href="home?page=${count.index}">${count.index}</a></li>
                                </c:forEach>
                            </c:if>

                        <a class="page-link" href="home?page=${requestScope.page}&other=next" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </body>
</html>
