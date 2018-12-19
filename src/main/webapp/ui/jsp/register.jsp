<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <title>Register</title>
</head>

<body >
  <div class="container" style="margin: 50px;border: 1px solid green;">
		<h3>CV Management System Registration</h3>
		<c:if test="${param.error ne null}">
			<div style="color: red">Invalid credentials.</div>
		</c:if>
		<form onsubmit="return false;" method="post">
			<div class="form-group">
				<label for="username">Username:</label>
        <input type="text" class="form-control" id="username" name="username">
			</div>
			<div class="form-group">
				<label for="pwd">Password:</label>
        <input type="password" class="form-control" id="pwd" name="password">
			</div>

			<button type="submit" class="btn btn-success"  onclick="register()">Submit</button>
      <a href="/login">or login</a>
<%--
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> --%>
		</form>
    <script>
      register = function() {
        var xhr = new XMLHttpRequest();
        var url = "http://localhost:8081/users/createUser/ROLE_TRAINING_MANAGER";
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          console.log(xhr.responseText);
        }
        };
        var username = document.getElementById('username').value;
        var pwd = document.getElementById('pwd').value;

        var data = JSON.stringify({
	         "username":username,
	         "password":pwd,
	         "enabled":true,
	         "role":"ROLE_TRAINEE"
        });
        xhr.send(data);
        document.getElementById('username').value="";
        document.getElementById('pwd').value="";
        window.location.href = "/login";
        alert("Successfully registered!")
      }
    </script>
	</div>

</body>
</html>
