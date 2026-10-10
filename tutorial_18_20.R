#' 启动第18-20讲互动式R课程
#'
#' 启动R语言基础教程第18-20讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_18_20 <- function() {
  learnr::run_tutorial(
    "18_20",
    package = "RMedLearn"
  )
}
