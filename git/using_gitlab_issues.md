# Using GitLab Issues

项目中有功能需要完成、有 bug 需要修复。如何将讨论、开发进度、commit 信息都记录在案？GitLab 提供了 Issues。


## 新增一个 Issue

从项目页面侧边栏进入 Issues，例如 [demo project issues](http://202.11.11.201/qingpei/demo-project/issues)，可以看到现有的 issues。

点击`New Issue`可以新建一个 issue，填写问题描述或功能需求后提交，如 [issue #2](http://202.11.11.201/qingpei/demo-project/issues/2)。

## 开发讨论

项目成员可以在 Issue 页面进行评论，评论中可以`@`其他人；可以贴commit hash，会自动生成链接；可以上传文件、图片作参考。

## 关闭 Issue

当一个功能或问题被解决后，可以人工关闭。

如果是修改了代码解决了问题，推荐的做法是在 commit log 里附上一句 `Fix #2` 或 `Fixes #3` 等[特殊标记](http://202.11.11.201/help/customization/issue_closing.md)。GitLab会自动用该 commit 关闭相应的 issue。例如 [这个 commit](http://202.11.11.201/qingpei/demo-project/commit/9e14a1534e851381973e930be09df07c152580f3) 自动关闭了 [issue #2](http://202.11.11.201/qingpei/demo-project/issues/2)。