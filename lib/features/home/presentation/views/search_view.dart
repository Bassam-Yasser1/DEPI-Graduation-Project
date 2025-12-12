import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Boslah/core/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_text_style.dart';
import '../../controllers/search_controller.dart';

class SearchView extends GetView<searchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                SearchField(
                  onChange: (a) async {
                    await controller.onchange(a);
                  },
                  controller: controller.sController,
                  onPressed: () async {
                    print(";;;;;;;;;");
                    if (controller.sController.text.isNotEmpty) {
                      print(";;;;;;;;;");

                      try {
                        await controller.loadData();
                      } on AppException catch (e) {
                        showSnackBar(e.msg);
                      } catch (e) {
                        showSnackBar(e.toString());
                      }
                      print(";;;;;;;;;");
                    }
                  },
                ),
                Gap(25.h),

                Expanded(
                  child: Obx(() {
                    if (controller.historySearch.isEmpty &&
                        controller.searchList.isEmpty) {
                      return const Center(child: Text('No search history yet'));
                    }
                    if (controller.historySearch.isNotEmpty &&
                        controller.searchList.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Search',
                                style: AppTextStyle.semiBold24.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  controller.clearHistory();
                                },
                                label: const Text('Clear all'),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.historySearch.length,
                              itemBuilder: (ctx, index) => SizedBox(
                                height: 60,
                                child: Card(
                                  elevation: 3,
                                  // color: AppColors.darkSurface,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.history,
                                          color: AppColors.main,
                                          size: 25,
                                        ),
                                        Gap(10.w),
                                        Text(
                                          controller.historySearch[index].query,
                                          style: AppTextStyle.medium20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Result',
                          style: AppTextStyle.semiBold24.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Gap(10.h),
                        controller.searchList.isEmpty
                            ? Center(
                                child: Text(
                                  'No place',
                                  style: AppTextStyle.bold26.copyWith(
                                    color: const Color.fromARGB(
                                      147,
                                      158,
                                      158,
                                      158,
                                    ),
                                    fontSize: 28.sp,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.separated(
                                  itemCount: controller.searchList.length,
                                  itemBuilder: (ctx, index) => PlaceCard(index),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return const Gap(10);
                                      },
                                ),
                              ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceCard extends GetView<searchController> {
  const PlaceCard(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/details', arguments: controller.searchList[index]);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child:
                  controller.searchList[index].isAssetPath(
                    controller.searchList[index].image!,
                  )
                  ? Image.asset(
                      controller.searchList[index].image!,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.searchList[index].image!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.fill,
                    ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Text(
                controller.searchList[index].name,
                style: AppTextStyle.semiBold24,
              ),
            ),
            controller.searchList[index].desc != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      '${controller.searchList[index].desc}',
                      style: AppTextStyle.semiBold18.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Gap(5),
          ],
        ),
      ),
    );
  }
}
