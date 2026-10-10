#' Run the RMedLearn examination interface
#'
#' @param paper Path to exam paper (.rds or .json). If NULL, opens file chooser.
#' @return Invisibly returns after the learnr session is closed.
#' @export
run_exam <- function(paper = NULL) {
  if (is.null(paper)) paper <- file.choose()

  paper <- normalizePath(
    paper,
    winslash = "/",
    mustWork = TRUE
  )

  ext <- tolower(tools::file_ext(paper))
  test <- tryCatch(
    {
      if (identical(ext, "json")) {
        if (!requireNamespace("jsonlite", quietly = TRUE)) {
          stop("读取 JSON 试卷需要安装 jsonlite。")
        }
        jsonlite::fromJSON(paper, simplifyVector = FALSE)
      } else {
        readRDS(paper)
      }
    },
    error = function(e) {
      stop(
        "无法读取试卷文件：",
        conditionMessage(e),
        call. = FALSE
      )
    }
  )

  required <- c("exam_id", "title", "questions")
  missing <- setdiff(required, names(test))
  if (length(missing) > 0L) {
    stop(
      "试卷文件缺少字段：",
      paste(missing, collapse = ", "),
      call. = FALSE
    )
  }

  old <- Sys.getenv("RMEDLEARN_EXAM_PAPER", unset = NA_character_)
  Sys.setenv(RMEDLEARN_EXAM_PAPER = paper)

  on.exit({
    if (is.na(old)) Sys.unsetenv("RMEDLEARN_EXAM_PAPER") else Sys.setenv(RMEDLEARN_EXAM_PAPER = old)
  }, add = TRUE)

  learnr::run_tutorial(
    "exam",
    package = "RMedLearn"
  )

  invisible(TRUE)
}
