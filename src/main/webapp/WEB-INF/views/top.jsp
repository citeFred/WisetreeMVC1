<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	
  <title>Goods Store Webpage</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  </style>
</head>
<body>
<!-- context명 세팅 "multiweb"  -->
<c:set var="myctx" value="${pageContext.request.contextPath}"/>

<div class="jumbotron text-center" style="margin-bottom:0">
  <h1>Goods Store Web Page</h1>
  <p>World variety goods!</p> 
</div>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="${myctx}/index">GOODS STORE</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
       <li class="nav-item">
        <a class="nav-link" href="${myctx}/join">Join</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/admin/userList">Users</a>
      </li>
      <%-- <c:if test="${loginUser eq null}"> --%>
	      <li class="nav-item"><!-- FOOT.jsp에서 MODAL 임포트함. -->
	        <a class="nav-link" href="#loginModal" data-toggle="modal">Login</a>
	      </li>
      <%-- </c:if> --%>
      <%-- <c:if test="${loginUser ne null}"> --%>
      	  <li class="nav-item bg-primary">
	        <a class="nav-link text-white" href="#">${loginUser.userid }님 로그인중..</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="${myctx}/logout">Logout</a>
	      </li>
      <%-- </c:if> --%>
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/admin/prodForm">Add Products</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/admin/prodList">Products List</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/user/cartList">My Cart</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/notice_board/list">Notice List</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/notice_board/write">Notice Write</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/review/list">Review List</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/review/write">Review Write</a>
      </li>  
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/board/list">Board List</a>
      </li>    
      <li class="nav-item">
        <a class="nav-link" href="${myctx}/board/write">Board Write</a>
      </li>
    </ul>
  </div>  
</nav>