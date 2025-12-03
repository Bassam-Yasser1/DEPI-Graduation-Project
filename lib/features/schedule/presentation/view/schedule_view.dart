
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/utilities/app_colors.dart';


class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, bottom: 12),
            child: const Column(
              children: [
                Text(
                  "Your Schedule",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "See your upcoming tours",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCardFilttring(1, 'All'),
                buildCardFilttring(2, 'Upcoming', IconData: Icons.pending_outlined),
                buildCardFilttring(
                  3,
                  'Completed',
                  IconData: Icons.done_all,
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: ListView.builder(itemCount: 4,itemBuilder: (_,index){
              return const TourCard();
            }),
          )
        ],
      )
      
      ),
    );
  }

Widget buildCardFilttring(int index, String label, {IconData}) {
  return Obx(() {
    bool isSelected = controller.selectedCard.value == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          controller.selectedCard.value = index;
          // calling the api
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: isSelected ? AppColors.main : Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Row(
              children: [
                IconData != null
                    ? Row(
                  children: [
                    Icon(
                      IconData,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const Gap(10),
                  ],
                )
                    : const SizedBox.shrink(),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

}

class TourCard extends GetView<ScheduleController> {
  const TourCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------- IMAGE + BADGES --------------------
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    "https://picsum.photos/800/400", // الصورة
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // badge left
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                        const Gap(5),
                        Text(
                          "In Progress",
                          style: TextStyle(
                              fontSize: 13, color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                ),

                // badge right
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color:AppColors.main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Today",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),

            // -------------------- TITLE --------------------
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Historic City Walking Tour",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // -------------------- NOTE --------------------
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
              child: Text(
                "I'm going to Paris to walk a little, eat, and go shopping.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
