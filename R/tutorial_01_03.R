#' 启动第1-3讲互动式R课程
#'
#' 启动R语言基础教程第1-3讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_01_03 <- function() {
  learnr::run_tutorial(
    "01_03",
    package = "RMedLearn"
  )
}
