<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
<title><t:insertAttribute name="title"/></title>

<style type="text/css">

#top header {
	width: 100%;
	background: #FFFFFF;
	color: #004d31;
	padding-top: 20px;
	padding-bottom: 20px;
	text-align: center;
}

#top .parentheader{
	display:flex;
	align-items: center;
	justify-content: space-between;
}

</style>

</head>
<body>
   <div id="container">
      <div id="top">
         <t:insertAttribute name="top"/>
      </div>
      <div id="body">
         <t:insertAttribute name="body"/>
      </div>
   </div>
</body>
</html>