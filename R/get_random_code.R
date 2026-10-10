#' Map a student ID to an exam dataset number
#'
#' Deterministically maps a student ID to an integer from 1 to 10.
#' The same student ID always receives the same dataset number.
#'
#' @param student_id Student ID.
#' @return Integer from 1 to 10.
#' @export
get_random_code <- function(student_id) {
  student_id <- trimws(as.character(student_id))

  if (length(student_id) != 1L ||
      is.na(student_id) ||
      !nzchar(student_id)) {
    stop("student_id must be a non-empty value.", call. = FALSE)
  }

  # A deterministic SHA-256 mapping.
  # Note: because this function runs locally, it should not be treated
  # as a cryptographic secret. Its purpose is stable assignment.
  key <- paste0("RMedLearn|exam-map-v1|", student_id)
  hex <- digest::digest(key, algo = "sha256", serialize = FALSE)

  # Use 7 hex characters so strtoi() remains safely within integer range.
  value <- strtoi(substr(hex, 1L, 7L), base = 16L)

  as.integer((value %% 10L) + 1L)
}
