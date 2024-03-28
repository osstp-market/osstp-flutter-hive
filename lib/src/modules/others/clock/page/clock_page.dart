import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:fluro/fluro.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../common/utils/show_dialog.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../../../../common/utils/string_utils.dart';
import '../../../../../common/widget/divider_line_widget.dart';
import '../../../../../common/widget/inkWell_button.dart';
import '../../../../../src/modules/others/clock/controller/clock_controller.dart';
import '../../../../../src/modules/routers/routers_navigator.dart';
import '../../../../../common/utils/screen_utils.dart';
import '../view/flip_view.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    NavigatePushArguments? arguments = context.settings?.arguments as NavigatePushArguments?;
    double maxWidth = 0;
    if (orientation == Orientation.portrait) {
      maxWidth = screenWidth;
    } else if (orientation == Orientation.landscape) {
      maxWidth = screenWidth / 2;
    }
    return GetBuilder<ClockController>(
      init: ClockController(),
      initState: (state) {},
      dispose: (state) {
        try {
          state.controller?.stopWatchTimer.dispose();
        } catch (_) {

        }
      },
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    arguments?.isPreview != true
                        ? const SizedBox()
                        : InkWellButton.InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(Icons.arrow_back),
                            ),
                            onTap: () async {
                              controller.stopWatchTimer.onStopTimer();
                              Application.pop(context);
                            },
                          ),
                    Obx(
                      () => Flexible(
                        child: AutoSizeText(
                          '${controller.dateTime.value.year}年${controller.dateTime.value.month}月${controller.dateTime.value.day}日 星期${controller.weeks[controller.dateTime.value.weekday - 1]}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 26.0,
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    arguments?.isPreview != true
                        ? const SizedBox()
                        : InkWellButton.InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(Icons.settings_rounded),
                            ),
                            onTap: () {
                              controller.format24(change: true);
                            },
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: orientation == Orientation.portrait
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _time(controller),
                            Row(
                              children: [
                                Expanded(
                                  child: DividerLineView(height: 20),
                                ),
                              ],
                            ),
                            _calendar(controller),
                            Row(
                              children: [
                                Expanded(
                                    child: DividerLineView(
                                  height: 20,
                                )),
                              ],
                            ),
                            _holiday(controller, maxWidth),
                            Row(
                              children: [
                                Expanded(
                                    child: DividerLineView(
                                  height: 20,
                                )),
                              ],
                            ),
                            _weather(controller),
                          ],
                        )
                      : Column(
                          // 横向
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _time(controller),
                                // _weather(controller),
                              ],
                            ),
                            Row(
                              children: [Expanded(child: DividerLineView(height: 20))],
                            ),
                            _hWeather(controller),
                            Row(
                              children: [Expanded(child: DividerLineView(height: 20))],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: _calendar(controller),
                                  ),
                                ),
                                _holiday(controller, maxWidth),
                              ],
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _time(ClockController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => FlipNumText(
                controller.formatHour.value,
                24,
                calNum: 0,
              ),
            ),
            Text(
              ":",
              style: TextStyle(fontSize: (screenWidth / 5 + 10) - 30),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => FlipNumText(
                    controller.dateTime.value.minute,
                    60,
                    calNum: 0,
                  ),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: (screenWidth / 5 + 10) - 30),
                ),
                /// Display every second.
                StreamBuilder<int>(
                  stream: controller.stopWatchTimer.secondTime,
                  initialData: controller.stopWatchTimer.secondTime.value,
                  builder: (context, snap) {
                    return FlipNumText(
                      controller.second(),
                      60,
                      calNum: 0,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // 横向
  _hWeather(ClockController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${controller.weatherModel.value.result?.city ?? ""} 今日天气："),
              Row(
                children: [
                  const BoxedIcon(WeatherIcons.thermometer, size: 15),
                  Text(controller.weatherModel.value.result?.realtime?.temperature ?? ""),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: BoxedIcon(WeatherIcons.humidity, size: 15),
                  ),
                  Text(controller.weatherModel.value.result?.realtime?.humidity ?? ""),
                ],
              ),
              Row(
                // 天气情况
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: BoxedIcon(WeatherIcons.day_sunny, size: 15),
                  ),
                  Text(controller.weatherModel.value.result?.realtime?.info ?? ""),
                ],
              ),
              // Text("风力: ${controller.weatherModel.value.result?.realtime?.wid}"),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: BoxedIcon(WeatherIcons.wind, size: 15),
                  ),
                  Text(
                      "${controller.weatherModel.value.result?.realtime?.direct ?? ""} ${controller.weatherModel.value.result?.realtime?.power ?? ""}"),
                ],
              ),

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: BoxedIcon(WeatherIcons.earthquake, size: 15),
                  ),
                  Text(controller.weatherModel.value.result?.realtime?.aqi ?? ""),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: InkWellButton.InkWell(
              child: const Text(
                "未来几日天气",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                showGetXGeneralDialog(
                  title: "${controller.weatherModel.value.result?.city ?? ""} 未来天气",
                  contentWidget: SizedBox(
                    width: 300,
                    height: 130,
                    child: Obx(
                      () => Swiper(
                        autoplay: true,
                        scrollDirection: Axis.vertical,
                        axisDirection: AxisDirection.left,
                        autoplayDelay: 8000,
                        itemCount: controller.futureWeatherList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.futureWeatherList[index].date ?? ""),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const BoxedIcon(WeatherIcons.thermometer, size: 15),
                                          Text("  ${controller.futureWeatherList[index].temperature ?? ""}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const BoxedIcon(WeatherIcons.day_sunny, size: 15),
                                          Text("  ${controller.futureWeatherList[index].weather ?? ""}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const BoxedIcon(WeatherIcons.wind, size: 15),
                                          Text("  ${controller.futureWeatherList[index].direct ?? ""}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        // itemWidth: 200,
                        onTap: (index) async {
                          // showOilProvincePicker(context, controller);
                        },
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  // 纵向
  _weather(ClockController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${controller.weatherModel.value.result?.city ?? ""} 今日天气情况"),
                Row(
                  children: [
                    const BoxedIcon(WeatherIcons.thermometer, size: 15),
                    Text("  ${controller.weatherModel.value.result?.realtime?.temperature ?? ""}"),
                  ],
                ),
                Row(
                  children: [
                    const BoxedIcon(WeatherIcons.humidity, size: 15),
                    Text("  ${controller.weatherModel.value.result?.realtime?.humidity ?? ""}"),
                  ],
                ),

                Row(
                  // 天气情况
                  children: [
                    const BoxedIcon(WeatherIcons.day_sunny, size: 15),
                    Text("  ${controller.weatherModel.value.result?.realtime?.info ?? ""}"),
                  ],
                ),
                // Text("风力: ${controller.weatherModel.value.result?.realtime?.wid}"),
                Row(
                  children: [
                    const BoxedIcon(WeatherIcons.wind, size: 15),
                    Text(
                        "  ${controller.weatherModel.value.result?.realtime?.direct ?? ""} ${controller.weatherModel.value.result?.realtime?.power ?? ""}"),
                  ],
                ),

                Row(
                  children: [
                    const BoxedIcon(WeatherIcons.earthquake, size: 15),
                    Text("  ${controller.weatherModel.value.result?.realtime?.aqi ?? ""}"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SizedBox(
            width: 200,
            height: 130,
            child: Obx(
              () => Swiper(
                autoplay: true,
                scrollDirection: Axis.vertical,
                axisDirection: AxisDirection.left,
                autoplayDelay: 10000,
                index: controller.index.value,
                onIndexChanged: (index) {
                  controller.index.value = index;
                },
                controller: controller.loopController,
                itemCount: controller.futureWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${controller.weatherModel.value.result?.city ?? ""} 未来天气情况"),
                        Text(controller.futureWeatherList[index].date ?? ""),
                        Row(
                          children: [
                            const BoxedIcon(WeatherIcons.thermometer, size: 15),
                            Text("  ${controller.futureWeatherList[index].temperature ?? ""}"),
                          ],
                        ),
                        Row(
                          children: [
                            const BoxedIcon(WeatherIcons.day_sunny, size: 15),
                            Text("  ${controller.futureWeatherList[index].weather ?? ""}"),
                          ],
                        ),
                        Row(
                          children: [
                            const BoxedIcon(WeatherIcons.wind, size: 15),
                            Text("  ${controller.futureWeatherList[index].direct ?? ""}"),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                // itemWidth: 200,
                onTap: (index) async {
                  // showOilProvincePicker(context, controller);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _calendar(ClockController controller) {
    return Obx(
      () => controller.lunarModel.value.result == null
          ? const SizedBox()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${controller.lunarModel.value.result?.lubarmonth ?? ""} ${controller.lunarModel.value.result?.lunarday ?? ""}'),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(controller.lunarModel.value.result?.shengxiao ?? ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(controller.lunarModel.value.result?.lmonthname ?? ""),
                          ),
                          Text(controller.lunarModel.value.result?.jieqi ?? ""),
                        ],
                      ),

                      // Text("${controller.lunar.value.getFestivals()}"),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                                '${controller.lunarModel.value.result?.tiangandizhiyear ?? ""} ${controller.lunarModel.value.result?.tiangandizhimonth ?? ""} ${controller.lunarModel.value.result?.tiangandizhiday ?? ""}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(controller.lunarModel.value.result?.wuxingjiazi ?? ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(controller.lunarModel.value.result?.wuxingnayear ?? ""),
                          ),
                          Text(controller.lunarModel.value.result?.wuxingnamonth ?? ""),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("适宜："),
                          Flexible(child: Text(controller.lunarModel.value.result?.fitness ?? "")),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("不宜："),
                          Flexible(child: Text(controller.lunarModel.value.result?.taboo ?? "")),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _holiday(ClockController controller, double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => itIsEmpty(controller.holidayItemModel.value.name)
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "今天${controller.holidayItemModel.value.info ?? ""}：${controller.holidayItemModel.value.name ?? ""} ${controller.holidayItemModel.value.date ?? ""}",
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
        ),
        Obx(
          () => itIsEmpty(controller.futureHolidayItemModel.value.name)
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                        "未来${controller.futureHolidayItemModel.value.info ?? ""}：${controller.futureHolidayItemModel.value.name ?? ""} ${controller.futureHolidayItemModel.value.date ?? ""} ${controller.futureHolidayItemModel.value.lunarmonth ?? ""}${controller.futureHolidayItemModel.value.lunarday ?? ""} ${controller.futureHolidayItemModel.value.lunaryear ?? ""} ${controller.futureHolidayItemModel.value.cnweekday ?? ""}"),
                    itIsEmpty(controller.futureHolidayItemModel.value.tip)
                        ? const SizedBox()
                        : Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: AutoSizeText(controller.futureHolidayItemModel.value.tip ?? ""))
                  ],
                ),
        )
      ],
    );
  }

  // Widget get lightClock => AnalogClock(
  //   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
  //   width: 150.0,
  //   showNumbers: false,
  //   showDigitalClock: false,
  //   datetime: DateTime(2019, 1, 1, 10, 10, 35),
  //   key: const GlobalObjectKey(1),
  // );
  //
  // Widget get darkClock => AnalogClock.dark(
  //     width: 250.0,
  //     datetime: DateTime(2019, 1, 1, 12, 15, 45),
  //     key: const GlobalObjectKey(2),
  //     decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle));
  //
  // Widget get simpleClock => AnalogClock(
  //   decoration: BoxDecoration(
  //       border: Border.all(width: 2.0, color: Colors.black), color: Colors.transparent, shape: BoxShape.circle),
  //   width: 150.0,
  //   isLive: false,
  //   hourHandColor: Colors.black,
  //   minuteHandColor: Colors.black,
  //   showSecondHand: false,
  //   numberColor: Colors.black87,
  //   showNumbers: true,
  //   textScaleFactor: 1.4,
  //   showTicks: false,
  //   showDigitalClock: false,
  //   datetime: DateTime(2019, 1, 1, 9, 12, 15),
  //   key: const GlobalObjectKey(3),
  // );
}
