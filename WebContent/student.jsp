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
									<li class="active"><a href="javascript:void(0);"> Add
											Student Info</a></li>
									<li><a href="list">View Student info</a></li>

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
					var data = JSON.parse(data);
					$("#table tbody tr").remove();
					makeTableFromJson(data);
				}
			});
		}


		function makeTableFromJson(data) {
			for (var i = 0; i < data.length; i++) {
				var tr = $("<tr>");

				var td = $("<td>");
				td.append(i + 1);

				var td0 = $("<td>");
				td0.append(data[i]['firstName']);
				var td1 = $("<td>");
				td1.append(data[i]['province']['name']);
				var td2 = $("<td>");
				var edit = "<a href=customer/"+data[i]['id']+"/edit class='active btn-fab-mini' id=><span class='glyphicon glyphicon-edit'></span></a>&nbsp;&nbsp;";
				var del = $("<a class='btn-fab-mini' onclick='openModal()'><span class='fa fa-trash'></span></a>");
				del.attr("data-id", data[i]['id']);
				del.addClass('delete');
				td2.append(edit);
				td2.append(del);
				tr.append(td);
				tr.append(td0);
				tr.append(td1);
				tr.append(td2);

				$("#table tbody").append(tr);

			}
		}
		
	</script>
</body>
</html>
