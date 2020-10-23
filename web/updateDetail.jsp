<%-- 
    Document   : updateProduct
    Created on : Oct 7, 2020, 10:00:13 PM
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
        <title>Update Product Page</title>
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
                <h2>UPDATE PRODUCT</h2>
                <form action="submitUpdate" method="POST"> 
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" placeholder="Enter name" value="${sessionScope.UPDATE_DETAIL.name}" name="txtName" style="border: 1px solid;" rows="10"></input>
                        <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                            <font color="red"><small>${sessionScope.UPDATE_FAIL.errorName}</small></font> 
                            </c:if>
                    </div>  
                    <label>Link Image</label>
                    <div class="form-group mb-3">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="inputGroupFile02" name="txtImage">
                            <label class="custom-file-label" for="inputGroupFile02" aria-describedby="inputGroupFileAddon02" style="border: 1px solid;">${sessionScope.UPDATE_DETAIL.linkImage}</label> 
                            <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                                <font color="red"><small>${sessionScope.UPDATE_FAIL.errorLinkImage}</small></font> 
                                </c:if>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea type="text" class="form-control" placeholder="Enter description"  name="txtDescription" style="border: 1px solid;" rows="3">${sessionScope.UPDATE_DETAIL.description}</textarea> 
                        <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                            <font color="red"><small>${sessionScope.UPDATE_FAIL.errorDescription}</small></font> 
                            </c:if>
                    </div> 
                    <div class="row">
                        <div class="col-6">
                            <label>Price</label>
                            <div class="form-group input-group">       
                                <input type="number" min="0" class="form-control" name="txtPrice" placeholder="Enter price" style="border: 1px solid;" value="${sessionScope.UPDATE_DETAIL.price}"/>
                                <div class="input-group-append">
                                    <span class="input-group-text" style="border: 1px solid;">VND</span>
                                </div>    
                            </div>
                            <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                                <font color="red"><small>${sessionScope.UPDATE_FAIL.errorPrice}</small></font> 
                                </c:if>
                        </div>
                        <div class="col-6">
                            <label>Quantity</label>
                            <div class="form-group">
                                <input type="number" min="0" class="form-control" name="txtQuantity" placeholder="Enter quantity" style="border: 1px solid;" value="${sessionScope.UPDATE_DETAIL.quantity}"/>       
                                <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                                    <font color="red"><small>${sessionScope.UPDATE_FAIL.errorQuantity}</small></font> 
                                    </c:if>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label>Create Date</label>
                                <input type="date" class="form-control" placeholder="Enter create date" name="txtCreateDate" style="border: 1px solid;" value="${sessionScope.UPDATE_DETAIL.createDate}"/> 
                                <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                                    <font color="red"><small>${sessionScope.UPDATE_FAIL.errorCreateDate}</small></font> 
                                    </c:if>
                            </div>

                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label>Expiration Date</label>
                                <input type="date" class="form-control" placeholder="Enter expiration date" name="txtExpirateDate" style="border: 1px solid;" value="${sessionScope.UPDATE_DETAIL.expirateDate}"/> 
                                <c:if test="${not empty sessionScope.UPDATE_FAIL}">
                                    <font color="red"><small>${sessionScope.UPDATE_FAIL.errorExpirateDate}</small></font> 
                                    </c:if>
                            </div>

                        </div>
                    </div>

                    <div class="row">
                        <div class="col-8">
                            <div class="form-group">
                                <label>Category</label>
                                <select name="txtCategory" class="form-control" style="border: 1px solid;">
                                    <c:forEach var="category" items="${sessionScope.CATEGORY}"> 
                                        <c:if test="${sessionScope.UPDATE_DETAIL.categoryID == category.id}">
                                            <option value="${category.id}" selected>${category.name}</option>
                                        </c:if>
                                        <c:if test="${sessionScope.UPDATE_DETAIL.categoryID != category.id}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label>Status</label>
                                <select name="txtStatus" class="form-control" style="border: 1px solid;">
                                    <c:if test="${sessionScope.UPDATE_DETAIL.status == 1}">
                                        <option value="1" selected>Active</option>
                                    </c:if>
                                    <c:if test="${sessionScope.UPDATE_DETAIL.status != 1}">
                                        <option value="1">Active</option>
                                    </c:if>
                                    <c:if test="${sessionScope.UPDATE_DETAIL.status == 2}">
                                        <option value="2" selected>Deactive</option>
                                    </c:if>
                                    <c:if test="${sessionScope.UPDATE_DETAIL.status != 2}">
                                        <option value="2">Deactive</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                    </div>
                    <br>
                    <input type="hidden" name="id" value="${sessionScope.UPDATE_DETAIL.id}"/>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                    </br>
                </form>
            </div>
            <div class="col-3"></div>
            <c:remove var="UPDATE_FAIL" scope="session"></c:remove>
        </div>    
    </body>
    <script>
// Add the following code if you want the name of the file appear on select
        $(".custom-file-input").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>
</html>
