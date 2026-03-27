///|
test "shared validation and json contract" {
  let ok_request = @shared.SubmitTitleRequest::{ title: "Write docs" }
  @shared.validate_request(ok_request)

  let empty_warning = try {
    @shared.validate_request(@shared.SubmitTitleRequest::{ title: "   " })
    "unexpected"
  } catch {
    err => @shared.warning_text(err)
  }
  let too_long_response = @shared.SubmitTitleResponse::ValidationError(
    @shared.TitleValidationError::TooLong(26),
  )
  let forbidden_response = @shared.SubmitTitleResponse::ValidationError(
    @shared.TitleValidationError::ForbiddenHash,
  )

  assert_true(empty_warning.contains("empty"))
  assert_eq(
    too_long_response.to_json().stringify(),
    "[\"ValidationError\",[\"TooLong\",26]]",
  )
  assert_eq(
    forbidden_response.to_json().stringify(),
    "[\"ValidationError\",\"ForbiddenHash\"]",
  )

  let accepted_response = @shared.SubmitTitleResponse::Accepted("Write docs")
  let invalid_response = @shared.SubmitTitleResponse::InvalidJson
  assert_eq(
    accepted_response.to_json().stringify(),
    "[\"Accepted\",\"Write docs\"]",
  )
  assert_eq(invalid_response.to_json().stringify(), "\"InvalidJson\"")

  let accepted_show = Show::to_string(accepted_response)
  let forbidden_show = Show::to_string(forbidden_response)
  let invalid_show = Show::to_string(invalid_response)
  assert_eq(accepted_show, "accepted: Write docs")
  assert_true(forbidden_show.contains("validation_error"))
  assert_true(invalid_show.contains("invalid_json"))
}
