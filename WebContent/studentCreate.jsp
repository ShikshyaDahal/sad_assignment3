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


							<form id="studentForm">
								<div class="errors"></div>
								<div class="well bs-component">
									<div class="row">
										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">
													<label class="control-label" for="firstName ">First
														Name </label> <input class="form-control " name="firstName"
														tabindex="1" id="firstName" required />
												</div>
											</div>
										</div>

	
										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">

													<label class="control-label" for="Email ">Last Name
													</label> <input class="form-control " name="lastName" id="lastName"
														required />
												</div>
											</div>
										</div>
										
										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">

													<label class="control-label" for="Email ">Email </label> <input
														class="form-control " name="email" id="email" required />
												</div>
											</div>
										</div>

										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">

													<label class="control-label" for="PhoneNumber ">Phone
														Number </label> <input class="form-control " name="phoneNumber"
														id="phoneNumber" required />
												</div>
											</div>
										</div>

										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">

													<label class="control-label" for="Address ">Address
													</label> <input class="form-control " name="address" id="address"
														required />
												</div>
											</div>
										</div>


										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">

													<label class="control-label" for="province ">State/Province
													</label> <input class="form-control province" name="province"
														id="province" required />

												</div>
											</div>
										</div>


										<div class="col-md-3">
											<div class="form-group label-floating">
												<div class="input-group">
													<label class="control-label" for="zip ">Zip/PostalCode
													</label> <input class="form-control " name="postalCode"
														id="postalCode" required />
												</div>
											</div>
										</div>


									</div>
									<div class="row">
										<div class="col-md-8">
											<div class="form-group">
												<input type="button" class="btn btn-raised btn-info"
													name="btnSave" id="btnSave" value="Save" /> <input
													type="reset" class="btn btn-raised btn-warning"
													value="Cancel" />
											</div>
										</div>
									</div>
								</div>
							</form>



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

	<script>
		function convertToJson() {
			var studentData = {};
			studentData.firstName = $("#firstName").val();
			studentData.lastName = $("#lastName").val();
			studentData.email = $("#email").val();
			studentData.phoneNumber = $("#phoneNumber").val();
			studentData.address = $("#address").val();
			studentData.province = $("#province").val();
			studentData.postalCode = $("#postalCode").val();

			jsonData = JSON.stringify(studentData);
		}

		//ONCLICK EVENT BUTTON SAVE
		$("#btnSave").click(function() {
			var form = $("studentForm");
			convertToJson();
			$.ajax({
				url : 'api/student',
				type : 'POST',
				dataType : 'json',
				data : jsonData,
				contentType : 'application/json',
				complete : function(response) {
					if (response.status === 201) {
						location.href='list'
					}
				}
			});
		});
	</script>
</body>
</html>

