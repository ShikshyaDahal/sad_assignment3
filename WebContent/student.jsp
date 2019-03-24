<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<style>
.header {
	color: #36A0FF;
	font-size: 27px;
	padding: 10px;
}
</style>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

</head>
<body>
	<div>
		<div class="container">


			<div class="row">
				<div class="col-md-12">
					<div class="well well-sm">

						<fieldset>
							<legend class="text-center header">Student Info</legend>

							<div class="margin-bottom-20">
								<ul class="nav nav-tabs">
									<li><a href="/SadAssignment">Add Student info</a></li>
									<li class="active"><a href="javascript:void(0);"> Add
											Student Info</a></li>

								</ul>
							</div>

							<div class="table-responsive bs-component">
								<table id="table" class="table table-hover table-striped">
									<thead>
										<tr>
											<th>S.N.</th>
											<th>FirstName</th>
											<th>LastName</th>
											<th>Email</th>
											<th>Phone Number</th>
											<th>Address</th>
											<th>State/Province</th>
											<th>Postal Code</th>


										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>

							</div>


						</fieldset>
					</div>
				</div>

			</div>

		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		$(function() {
			loadDataByAjax();
		});

		function loadDataByAjax() {
			var data = $.ajax({
				url : 'api/student',
				method : 'GET',
				success : function(data) {
					console.log(data)
				 var data = JSON.parse(data);
					console.log(data)
					$("#table tbody tr").remove();
					console.log(data.length)
					makeTableFromJson(data);
				}
			});
		}
		
	
		function makeTableFromJson(data) {
			console.log(data)

			for (var i = 0; i < data.length; i++) {
				var tr = $("<tr>");

				var td = $("<td>");
				td.append(i + 1);

				var td0 = $("<td>");
				td0.append(data[i]['firstName']);
				
				var td1 = $("<td>");
				td1.append(data[i]['lastName']);
				
				var td2 = $("<td>");
				td2.append(data[i]['email']);
				
				var td3 = $("<td>");
				td3.append(data[i]['phoneNumber']);
				
				var td4 = $("<td>");
				td4.append(data[i]['address']);
				
				var td5 = $("<td>");
				td5.append(data[i]['province']);
				
				
				var td6 = $("<td>");
				td6.append(data[i]['postalCode']);
				
				tr.append(td);
				tr.append(td0);
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
				tr.append(td4);
				tr.append(td5);
				tr.append(td6);

				$("#table tbody").append(tr);

			}
		}
	</script>
</body>
</html>
