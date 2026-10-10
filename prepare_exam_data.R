#' Prepare the assigned exam dataset
#'
#' Copies the assigned internal exam dataset to the student's working
#' directory using the common filename exam_data.csv.
#'
#' @param dataset_id Integer from 1 to 10.
#' @param path Existing destination directory.
#' @param overwrite Whether an existing exam_data.csv should be overwritten.
#' @return Invisibly returns the copied file path.
#' @keywords internal
prepare_exam_data <- function(dataset_id, path, overwrite = TRUE) {
  dataset_id <- as.integer(dataset_id)

  if (length(dataset_id) != 1L ||
      is.na(dataset_id) ||
      dataset_id < 1L ||
      dataset_id > 10L) {
    stop("dataset_id must be an integer from 1 to 10.", call. = FALSE)
  }

  path <- path.expand(path)

  if (!dir.exists(path)) {
    stop("Working directory does not exist: ", path, call. = FALSE)
  }

  src <- system.file(
    "exam_data",
    sprintf("dataset_%d.csv", dataset_id),
    package = "RMedLearn"
  )

  if (!nzchar(src)) {
    stop(
      "Assigned exam dataset is missing from RMedLearn: dataset_",
      dataset_id,
      ".csv",
      call. = FALSE
    )
  }

  dest <- file.path(path, "exam_data.csv")

  ok <- file.copy(
    from = src,
    to = dest,
    overwrite = overwrite
  )

  if (!isTRUE(ok)) {
    stop("Failed to prepare exam_data.csv in: ", path, call. = FALSE)
  }

  invisible(dest)
}
