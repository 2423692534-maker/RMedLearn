#' 启动第15-17讲互动式R课程
#'
#' 启动R语言基础教程第15-17讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_15_17 <- function() {
  learnr::run_tutorial(
    "15_17",
    package = "RMedLearn"
  )
}
