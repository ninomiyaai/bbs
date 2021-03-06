<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>掲示板ホーム画面</title>
</head>
<body>
<h3>掲示板</h3>

<div class="header">
	<a href="newMessage">投稿する</a>
	<a href="userControl">ユーザー管理</a>
	<a href="logout">ログアウト</a>
</div>

<div class="main-contents">
<c:if test="${ not empty errorMessages }">
	<div class="errorMessages" style="color:red">
		<ul>
			<c:forEach items="${errorMessages}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="message"/>
</c:if>


<div class="narrowing">
	<form action="./" method="get"><br />

		<p>
		<label for="category">カテゴリー</label>
		<select name="category">
			<option value=""></option>
			<c:forEach items="${categories}" var="c">
				<c:if test="${c.category != category}">
					<option value="${c.category}">${c.category}</option>
				</c:if>
				<c:if test="${c.category == category}">
					<option value="${c.category}" selected>${c.category}</option>
				</c:if>
			</c:forEach>
		</select>
		</p>

		<p>
		<label for="oldDate">投稿日時</label>
			<input type="date" name="oldDate" value="${oldDate}">
		<label for="newDate">～</label>
			<input type="date" name="newDate" value="${newDate}">
		</p>

		<input type="submit" value="検索" />
	</form>
	<br /><input type="submit" value="リセット" onClick="location.href='./'"> <br /> <br />
</div>

<div class="messages" style="line-height:160%">
	<c:forEach items="${messages}" var="message" >
		<hr><hr>
		<div class="title"><h4 style="display:inline;">件名：</h4><c:out value="${message.title}" /></div>

		<div class="text"><h4 style="display:inline;">本文：</h4><br />
		<c:forEach var="s" items="${fn:split(message.text, '
		')}"><c:out value="${s}" /><br /></c:forEach></div>

		<div class="name"><h4 style="display:inline;">投稿者：</h4><c:out value="${message.name}" /></div>
		<div class="category"><h4 style="display:inline;">カテゴリー：</h4><c:out value="${message.category}" /></div>
		<div class="created_at"><fmt:formatDate value="${message.created_at}" pattern="yyyy/MM/dd HH:mm:ss" /></div>

		<div class="comments" style="padding-left:2em">
			<c:forEach items="${comments}" var="comment">
				<c:if test="${message.id == comment.message_id}">
					<hr>
					<div class="text"><h4 style="display:inline;">コメント：</h4><br />
					<c:forEach var="s" items="${fn:split(comment.text, '
					')}"><c:out value="${s}" /><br /></c:forEach></div>
					<div class="name"><h4 style="display:inline;">投稿者：</h4><c:out value="${comment.name}" /></div>
					<div class="created_at"><fmt:formatDate value="${comment.created_at}" pattern="yyyy/MM/dd HH:mm:ss" /></div>
				</c:if>
			</c:forEach>
			<hr>
			<label>コメント(500文字以下で入力)</label>
			<form action="comment" method="post">
				<input type="hidden" name="message_id" value="${message.id}">
				<textarea name="text" cols="50" rows="5" class="text-box"><c:out value="${comment.text}" /></textarea><br /><br />
				<input type="submit" value="コメントを投稿">
			</form>
		</div>
	</c:forEach>
</div>
</div>
</body>
</html>