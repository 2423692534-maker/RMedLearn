#' Prepare tutorial data files
#'
#' Copies the data files bundled with RMedLearn to a user-specified
#' working directory.
#'
#' @param path Destination directory. Defaults to the current working directory.
#' @param files Data files to copy.
#' @param overwrite Whether existing files should be overwritten.
#'
#' @return Invisibly returns the paths of the copied files.
#' @keywords internal
prepare_tutorial_data <- function(
    path = getwd(),
    files = c("elder1.csv", "elder2.csv"),
    overwrite = FALSE
) {

  if (!dir.exists(path)) {
    stop("Working directory does not exist: ", path)
  }

  src <- system.file(
    "extdata",
    files,
    package = "RMedLearn"
  )

  missing <- files[src == ""]

  if (length(missing) > 0) {
    stop(
      "Tutorial data files are missing from RMedLearn: ",
      paste(missing, collapse = ", ")
    )
  }

  dest <- file.path(path, files)

  need_copy <- overwrite | !file.exists(dest)

  if (any(need_copy)) {
    file.copy(
      from = src[need_copy],
      to = dest[need_copy],
      overwrite = overwrite
    )
  }

  invisible(dest)
}
