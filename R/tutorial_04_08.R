#' 启动第4-8讲互动式R课程
#'
#' 启动R语言基础教程第4-8讲。
#'
#' @return 不返回对象，直接启动learnr互动教程。
#' @export
tutorial_04_08 <- function() {
  learnr::run_tutorial(
    "04_08",
    package = "RMedLearn"
  )
}
