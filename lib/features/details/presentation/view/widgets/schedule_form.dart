import 'package:depi_graduation_project/core/database/models/schedules.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/utilities/app_colors.dart';

class ScheduleForm extends StatelessWidget {
  const ScheduleForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(25),

            Text("Schedule Visit", style: AppTextStyle.bold22),

            const Gap(20),

            const Text("Date"),
            const Gap(8),

            TextField(
              controller: controller.dateController,
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2050),
                );
                if (picked != null) {
                  controller.dateController.text =
                      "${picked.year}-${picked.month}-${picked.day}";
                }
              },
              decoration: InputDecoration(
                hintText: "Select a date",
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.main,
                    width: 2.8,
                  ),
                ),
              ),
            ),

            const Gap(20),

            const Text("Time"),
            const Gap(8),

            TextField(
              controller: controller.timeController,
              readOnly: true,
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  controller.timeController.text = picked.format(context);
                }
              },
              decoration: InputDecoration(
                hintText: "Choose a time",
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.main,
                    width: 2.8,
                  ),
                ),
              ),
            ),

            const Gap(20),

            const Text("Note (optional)"),
            const Gap(8),

            TextField(
              controller: controller.noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Leave a note...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.main,
                    width: 2.8,
                  ),
                ),
              ),
            ),

            const Gap(25),

            Center(
              child: SizedBox(
                height: 50,
                width: 250,

                child: ElevatedButton(
                  onPressed: () async {
                    final cont = Get.find<DetailsController>();
                    if (controller.dateController.text.isEmpty ||
                        controller.timeController.text.isEmpty) {
                      Get.snackbar('error', 'please fill Data and Hour');
                      return;
                    }
                    final sch = Schedule(
                      date: controller.dateController.text,
                      image: cont.place.image ?? '',
                      hour: controller.timeController.text,
                      note: controller.noteController.text,
                      name: cont.place.name,
                      lat: cont.place.lat,
                      lng: cont.place.lng,
                      userId: cloud.auth.currentUser?.id ?? '',
                      placeId: cont.place.placeId,
                      isDone: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                    );
                    await database.scheduledao.insertSchedule(sch);
                    controller.dateController.clear();
                    controller.timeController.clear();
                    controller.noteController.clear();
                    debugPrint('schedule object: ${sch.date}');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.main,
                  ),
                  child: const Text(
                    'confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const Gap(25),
          ],
        ),
      ),
    );
  }
}
