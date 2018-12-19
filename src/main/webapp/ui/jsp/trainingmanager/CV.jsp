<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <title>Admin CV</title>
</head>

<body>
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
    Admin view all cvs
    <p id  = "print"/>
  <button onClick="view()">click</button>
<script>
    view = function() {
      var xhrAuth = new XMLHttpRequest();
      var urlAuth = "http://localhost:9100/auth";
      xhrAuth.open("POST", urlAuth , false);
      var data = "{\"username\": \"trainer\",\"password\": \"12346\"}";
      //console.log(xhrAuth.readyState+" "+xhrAuth.status)
      xhrAuth.onload = function() {
        console.log("here")
        if (xhrAuth.readyState === 4 && xhrAuth.status === 200) {
          var fullToken = xhrAuth.getResponseHeader("Authorization");
          console.log(fullToken);
          var token=fullToken.replace("Bearer ","")
          console.log(token)
          var xhr = new XMLHttpRequest();
          var url = "http://localhost:8762/trainee/getAllCVs";
          xhr.open("GET", url, true);
          xhr.setRequestHeader('Authorization', 'Bearer '+token);
          xhr.setRequestHeader('Access-Control-Allow-Methods', 'OPTIONS');
                xhr.setRequestHeader('Access-Control-Allow-Origin', 'http://localhost:8000');
                xhr.setRequestHeader('Access-Control-Expose-Headers','Authorization')
                xhr.setRequestHeader('Access-Control-Allow-Headers','Authorization')
                xhr.setRequestHeader('Access-Control-Allow-Credentials', 'true');
          xhr.onload = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
              console.log(xhr.responseText);
              document.getElementById('print').innerHTML = xhr.responseText;
              console.log("here now");
            }
          };
          xhr.send();
        }
    };
    xhrAuth.send(data);

  };
  </script>

</body>
</html>
