# RMedLearn

用于医学与公共卫生统计教学的交互式 R 学习与考试工具。

本源码与 2026 年 10 月 10 日考试系统的 RMedLearn 0.2.0 安装包对应。考试页面已取消解除锁功能：激活后两小时内禁止重新激活或重置，保留误关闭后的答题恢复。恢复沿用原身份、数据、答案和开始时间。

## 从 GitHub 安装

源码仓库地址为 `2423692534-maker/RMedLearn`。推荐在 RStudio 中运行。

```r
options(repos = c(CRAN = "https://cloud.r-project.org"))

# remotes 用于安装；其余三个是学生考试脚本使用的额外依赖。
pkgs <- c("remotes", "openxlsx", "foreign", "dplyr")
need <- pkgs[!vapply(pkgs, requireNamespace, quietly = TRUE,
                    FUN.VALUE = logical(1))]
if (length(need) > 0) install.packages(need)

remotes::install_github(
  "2423692534-maker/RMedLearn",
  dependencies = NA,
  upgrade = "never"
)
```

`remotes` 会安装 DESCRIPTION 中声明的核心依赖。其余教学专题的可选依赖位于 Suggests，使用对应专题时按需要安装。

## 启动考试

从教师领取学生考试文件夹，包含 `exam_paper.json` 和 `x1.csv` 至 `x10.csv`。将该文件夹设为 RStudio 工作目录，然后运行：

```r
RMedLearn::run_exam(paper = "exam_paper.json")
```

当前试卷和 x 系列数据需单独提供，安装本包不会自动下载这些考试材料。考试窗口内与本地 RStudio 需按题目要求使用同一考试文件夹。文件夹必须允许写入，以保存提交文件。

锁定和恢复状态保存在本地 R 用户数据目录中。此机制适用于常规课堂流程；本地开源程序不构成阻止修改代码或删除本地状态文件的安全边界。

## 源码结构

- `DESCRIPTION`、`NAMESPACE`：包信息、依赖和导出函数。
- `R/`：R 函数源码。
- `man/`：函数帮助。
- `inst/tutorials/`：教学专题与考试页面。
- `inst/extdata/`：包内教学示例数据。

仓库不包含当前试卷的教师答案、答案密钥、学生答题记录或成绩表。

## 许可证

本项目沿用原源码的 MIT 许可证，参见 LICENSE.md。

公开仓库允许所有人查看和下载源码，并按许可证使用、修改和分发。
