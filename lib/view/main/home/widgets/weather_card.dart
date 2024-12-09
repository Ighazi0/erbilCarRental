import 'package:cached_network_image/cached_network_image.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/end_points.dart';
import 'package:erbil/view/app/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    return Obx(() => ShimmerEffect(
          isLoading: mainController.weatherData.value.id == null,
          child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: DateTime.now().hour > 18 ? nightSkyColor : skyColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
              child: mainController.weatherData.value.id == null
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          '${EndPoints().openWeatherMapImage}${mainController.weatherData.value.weather?.first.icon}.png'),
                                ),
                                Text(
                                  mainController.weatherData.value.weather
                                          ?.first.main ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${mainController.weatherData.value.main?.temp.toStringAsFixed(0) ?? ''}\u00B0',
                              style: const TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Spacer(),
                            StreamBuilder<DateTime>(
                              stream: mainController.getTimeStream(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    DateFormat('HH:mm').format(DateTime.now()),
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                final time = snapshot.data!;
                                return Text(
                                  DateFormat('HH:mm').format(time),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            Text(
                              DateFormat('EE, dd MMM').format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              mainController.weatherData.value.name ?? '',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                          ],
                        )
                      ],
                    )),
        ));
  }
}
