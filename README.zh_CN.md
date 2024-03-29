# HIVE

## 你只需要负责业务开发，其他交给HIVE！！

- [English](./README.md)
- [简体中文](./README.zh_CN.md)

# 简介
HIVE：一款跨平台的产品级架构APP脚手架，Flutter开发，同时支持Android和iOS平台，基础功能组件高度封装、低耦合，可以根据产品需求，快速集成、发布高质量产品。

## 1.使用HIVE说明
```
- Flutter SDK版本  v3.19.0
- IDE推荐：Android Studio
- 最低支持iOS12系统
- 最低支持Android 5.0系统
```

使用方式有两种：

1、直接克隆此仓库代码，修改相应的配置，开发新项目的业务逻辑，基础工具类基本满足开发需求；

2、使用[git subtree add]()方式管理[HIVE]()源代码，后续基础功能组件完善，方便升级更新；

下面是 git subtree add 使用说明：

git subtree add --prefix=sub/project 新建<new project name>工程时，拉取源基础代码作为开发库
```shell
git subtree add --prefix=<new project name> https://github.com/osstp-market/osstp-flutter-hive.git main --squash
```
[注意：[git subtree add --prefix=...]拉取源代码后，立即新建一个SRC分支，此分支只用来拉取HIVE最新代码，然后再合并到开发分支。开发新功能时，新建分支，也不要将代码合并到SRC分支中，方便新项目和HIVE代码分离。]()

推送到新工程<new project name>仓库
```shell
git push
```
从源仓库拉取更新最新代码
```shell
git subtree pull --prefix=<new project name> https://github.com/osstp-market/osstp-flutter-hive.git main --squash
```
推送修改到源代码仓库（[源代码管理员权限]()，基础库封装内容在源代码仓库修改后提交，新项目再从源仓库拉取更新最新代码）

```shell
git subtree push --prefix=<new project name> https://github.com/osstp-market/osstp-flutter-hive.git main
```

## 2、修改HIVE配置后，开发新App业务功能，实现快速基础功能配置

1、plugins基础封装导入([此版本没有公开plugins私有库，如果想使用HIVE整体代码，请联系仓库管理员]())。如果使用自己引入的也可以，相应代码改动会增加工作量；

2、在main_dev/sit/uat/prod.dart项目文件中配置[ApplicationConfig.instance.initConfig()]()相应环境的参数，如果新增自定义初始化配置，可以修改[lib/common/config/config_manager.dart]()文件；

3、仿照[lib/src/modules/routers]()目录下文件，创建路由配置，最好是单独建立文件管理，防止后续拉取最新HIVE代码，出现冲突；

4、修改[lib/src/modules/main_tabbar]()目录下文件，创建主画面，新的基础工程搭建完事，可以开发新业务内容。

[注意：HIVE仓库代码仅供参考，私有仓库没有提交，若想使用，请联系HIVE源代码管理员]()

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
* [列表下拉刷新 上拉加载更多]()

# 打包脚本
iOS打包
flutter build ios --release --flavor dev --target lib/main_dev.dart
cd ios
fastlane dev
flutter build ios --release --flavor stg --target lib/main_sit.dart
cd ios
fastlane sit
flutter build ios --release --flavor uat --target lib/main_uat.dart
cd ios
fastlane uat
flutter build ios --release --flavor prod --target lib/main_prod.dart
cd ios
fastlane pro

Android 打包
flutter build apk -t lib/main_dev.dart --flavor dev
flutter build apk -t lib/main_sit.dart --flavor sit
flutter build apk -t lib/main_uat.dart --flavor uat
flutter build apk -t lib/main_prod.dart --flavor prod


# NOTE

| **PRIVATE** |
|-------------|
| [私有仓库为工程核心 目前不准备公开 工程整体架构思路仅供参考]()|