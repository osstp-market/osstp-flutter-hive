#osstp_flutter_hive

- [English](./README.md)
- [简体中文](./README.zh_CN.md)

# 简介
《HIVE》：一款跨平台的产品级架构APP脚手架，基础功能组件高度封装、低耦合，可以根据产品需求，快速集成、发布高质量产品。

## 1.使用说明
```
- Flutter SDK版本  v3.10.6
- IDE推荐：Android Studio
```
git subtree add --prefix=sub/project 新建<new project name>工程时，拉取源基础代码作为开发库
```shell
git subtree add --prefix=<new project name> https://github.com/iarchitecture/osstp-flutter-hive.git main --squash
```
推送到新工程<new project name>仓库
```shell
git push
```
从源仓库拉取更新最新代码
```shell
git subtree pull --prefix=<new project name> https://github.com/iarchitecture/osstp-flutter-hive.git main --squash
```
推送修改到源代码仓库（尽量不要使用该操作，基础库封装内容最好在源代码仓库修改后提交，新项目再从源仓库拉取更新最新代码）
```shell
git subtree push --prefix=<new project name> https://github.com/iarchitecture/osstp-flutter-hive.git main
```

1、在plugins目录引入私有库，具体请看[README.md](./plugins/README.md)
2、在工程根目录下执行下面脚本，实现model序列化功能
```bash
dart run build_runner build --delete-conflicting-outputs
```
3、Edit Configurations 设置开发环境，运行工程项目
````
工程默认配置[dev][sit][uat][prod]环境
在Build flavor设置dev、sit、uat、prod分别指向main_dev.dart、main_sit.dart、main_uat.dart、main_prod.dart时，与上面四个环境一一对应
可以根据开发测试需求，指定编译运行
````
## 2.架构实现的基础功能
* [启动画面]()
* [引导画面]()
* [Badge显示]()
* [国际化（English, Chinese）]()
* [暗黑模式]()
* [登录]()
* [注册]()
* [画面切换全局监听]()

# NOTE

| **PRIVATE** |
|-------------|
| [私有仓库为工程核心 目前不准备公开 工程整体架构思路仅供参考]()|