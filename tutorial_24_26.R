#' 启动第24-26讲互动式R课程
#'
#' 启动R语言基础教程第24-26讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_24_26 <- function() {
  learnr::run_tutorial(
    "24_26",
    package = "RMedLearn"
  )
}
