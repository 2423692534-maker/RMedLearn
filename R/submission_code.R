encode_exam_submission <- function(record) {
  payload <- jsonlite::toJSON(
    record,
    auto_unbox = TRUE,
    null = "null",
    digits = NA,
    POSIXt = "ISO8601",
    pretty = FALSE
  )

  envelope <- list(
    version = 1L,
    checksum = digest::digest(
      payload,
      algo = "sha256",
      serialize = FALSE
    ),
    payload = payload
  )

  envelope_json <- jsonlite::toJSON(
    envelope,
    auto_unbox = TRUE,
    null = "null",
    pretty = FALSE
  )

  compressed <- memCompress(
    charToRaw(enc2utf8(envelope_json)),
    type = "gzip"
  )

  base64enc::base64encode(compressed)
}

decode_exam_submission <- function(code) {
  raw_compressed <- base64enc::base64decode(code)
  raw_json <- memDecompress(raw_compressed, type = "gzip")

  envelope <- jsonlite::fromJSON(
    rawToChar(raw_json),
    simplifyVector = FALSE
  )

  expected <- digest::digest(
    envelope$payload,
    algo = "sha256",
    serialize = FALSE
  )

  if (!identical(expected, envelope$checksum)) {
    stop("Submission code checksum verification failed.", call. = FALSE)
  }

  jsonlite::fromJSON(
    envelope$payload,
    simplifyVector = FALSE
  )
}

.exam_lock_file <- function() {
  dir <- tools::R_user_dir("RMedLearn", which = "data")
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  file.path(dir, "exam_submission_lock.rds")
}

exam_lock_status <- function(student_id, exam_id, hours = 2) {
  path <- .exam_lock_file()

  if (!file.exists(path)) {
    return(list(locked = FALSE, remaining_minutes = 0))
  }

  x <- tryCatch(readRDS(path), error = function(e) NULL)

  if (is.null(x) ||
      !identical(as.character(x$student_id), as.character(student_id)) ||
      !identical(as.character(x$exam_id), as.character(exam_id))) {
    return(list(locked = FALSE, remaining_minutes = 0))
  }

  elapsed <- as.numeric(
    difftime(Sys.time(), x$submitted_at, units = "hours")
  )

  if (is.na(elapsed) || elapsed >= hours) {
    return(list(locked = FALSE, remaining_minutes = 0))
  }

  list(
    locked = TRUE,
    remaining_minutes = ceiling((hours - elapsed) * 60)
  )
}

write_exam_lock <- function(student_id, exam_id, submitted_at = Sys.time()) {
  saveRDS(
    list(
      student_id = as.character(student_id),
      exam_id = as.character(exam_id),
      submitted_at = submitted_at
    ),
    .exam_lock_file()
  )

  invisible(TRUE)
}
