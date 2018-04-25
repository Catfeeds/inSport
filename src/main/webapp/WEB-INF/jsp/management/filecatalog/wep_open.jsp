<%@page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="static/viewerjs/docs/css/viewer.css" />
    <script src="static/viewerjs/docs/js/viewer.js"></script>
    <script src="static/js/jquery-2.1.1.js"></script>
</head>
<body>
    <iframe id="iframe" src="" style="width: 90%;height: 90%"  ></iframe>
</body>
<script>
    window.onload=function(){
        $("#iframe").attr("src","${pd.FILE_URL}");
    }
</script>
</html>
