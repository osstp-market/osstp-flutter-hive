import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routers/routers_config.dart';
import '../../../routers/routers_navigator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../common/utils/string_utils.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../../../common/widget/refresh_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../webview/page/webview_loading_widget_page.dart';
import '../controller/refresh_page_controller.dart';

class RefreshPage extends StatelessWidget {
  const RefreshPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RefreshPageController>(
      init: RefreshPageController(),
      initState: (getState) {},
      builder: (RefreshPageController controller) {
        return Scaffold(
          appBar: MainAppBar(title: S.current.tabbar_home),
          body: Obx(
            () => RefreshWidget(
              refreshController: controller.refreshController,
              onRefresh: () => controller.onRefresh(),
              onLoading: () => controller.onLoading(),
              child: ListView(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height / 3.5,
                    child: Swiper(
                      autoplay: true,
                      // layout: SwiperLayout.CUSTOM,// custom animation UI
                      // customLayoutOption: CustomLayoutOption(
                      //     startIndex: -1,
                      //     stateCount: 3
                      // )..addRotate([
                      //   -45.0/180,
                      //   0.0,
                      //   45.0/180
                      // ])..addTranslate([
                      //   const Offset(-370.0, -40.0),
                      //   const Offset(0.0, 0.0),
                      //   const Offset(370.0, -40.0)
                      // ]),
                      index: controller.index.value,
                      onIndexChanged: (index) {
                        controller.index.value = index;
                      },
                      controller: controller.swiperController,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: controller.newsList[index].picUrl ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.colorBurn)),
                            ),
                          ),
                          placeholder: (context, url) => Padding(
                              padding: EdgeInsets.all(Get.height / 10), child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) => ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: Icon(
                              Icons.image_rounded,
                              size: Get.width / 3.5,
                            ),
                          ),
                        );
                      },
                      itemWidth: Get.width,
                      itemHeight: Get.height / 3.5,
                      itemCount: controller.newsList.length,
                      // pagination:  const SwiperPagination(),
                      // control: const SwiperControl(),
                      onTap: (index) async {
                        if (await canLaunchUrlString(stringValue(controller.newsList[index].url))) {
                          launchUrlString(controller.newsList[index].url ?? '');
                        }
                      },
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // itemExtent: 100.0,
                    itemCount: controller.newsList.length,
                    itemBuilder: (context, index) => Card(
                      child: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 80,
                                margin: const EdgeInsets.only(top: 2, right: 5),
                                child: CachedNetworkImage(
                                  imageUrl: stringValue(controller.newsList[index].picUrl),
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  ),
                                  placeholder: (context, url) => const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: const Icon(
                                      Icons.error,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stringValue(controller.newsList[index].title),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        stringValue(controller.newsList[index].description),
                                        style: const TextStyle(fontSize: 10),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${stringValue(controller.newsList[index].source)}：${stringValue(controller.newsList[index].ctime)}',
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Application.push(context, Routers.webViewLoadingPage,
                                  routeSettings: RouteSettings(
                                      name: Routers.webViewLoadingPage,
                                      arguments: WebViewLoadingModel(
                                          title: controller.newsList[index].title,
                                          url: controller.newsList[index].url)))
                              ?.then((value) {
                            print(value);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
