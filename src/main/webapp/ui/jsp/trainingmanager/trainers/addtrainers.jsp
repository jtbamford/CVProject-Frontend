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
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">CV Management</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <a class="nav-link" href="/homepage">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/trainingmanager/adminpage">My Account</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/trainingmanager/CV">CV's</a>
        <li class="nav-item dropdown">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Trainees
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="/trainingmanager/trainees/viewtrainees">View</a>
              <a class="dropdown-item" href="/trainingmanager/trainees/addtrainees">Add</a>
              <a class="dropdown-item" href="/trainingmanager/trainees/edittrainees">Amend</a>
            </div>
          </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Trainers
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href="/trainingmanager/trainers/viewtrainers">View</a>
            <a class="dropdown-item" href="/trainingmanager/trainers/addtrainers">Add</a>
            <a class="dropdown-item" href="/trainingmanager/trainers/edittrainers">Amend</a>
          </div>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="nav-item">
          <a class="nav-link" href="<c:url value="/perform_logout" />">Logout</a>
        </li>
      </ul>
    </div>
  </nav>
    <div class="container" style="margin: 50px;border: 1px solid green;">
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

			<button type="submit" class="btn btn-success"  onclick="register()">Add</button>
		</form>
    <script>
      register = function() {
        var xhr = new XMLHttpRequest();
        var url = "http://localhost:8081/users/createUser";
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
	         "role":"ROLE_TRAINER"
        });
        xhr.send(data);
        document.getElementById('username').value="";
        document.getElementById('pwd').value="";
        alert("Successfully added!")
      }
    </script>
	</div>

</body>
</html>
