<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="prod" items="${requestScope.listado}">
  <c:set var="producto" value="${prod}" scope="request"></c:set>
  <jsp:include page="producto.jsp"></jsp:include>
</c:forEach>
