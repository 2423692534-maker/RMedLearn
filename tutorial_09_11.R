#' 启动第9-11讲互动式R课程
#'
#' 启动R语言基础教程第9-11讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_09_11 <- function() {
  learnr::run_tutorial(
    "09_11",
    package = "RMedLearn"
  )
}
