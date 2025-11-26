import 'package:depi_graduation_project/features/auth/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utilities/app_text_style.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person_outline,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 1,
                shadowColor: Colors.white,
                child: buildSearch(),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCardFilttring(1, 'All'),
                    buildCardFilttring(2, 'Museums', IconData: Icons.museum),
                    buildCardFilttring(
                      3,
                      'Restaurants',
                      IconData: Icons.restaurant_sharp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardFilttring(int index, String label, {IconData}) {
    return Obx(() {
      bool isSelected = controller.selectedCard.value == index;
      return InkWell(
        onTap: () {
          controller.selectedCard.value = index;
          // calling the api
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: isSelected ? Colors.deepOrangeAccent : Colors.grey.shade300,
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
                            const SizedBox(width: 10),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20,
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

  TextField buildSearch() {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {
            //search code
          },
          icon: Icon(
            Icons.search,
            color: Colors.deepOrangeAccent.shade200,
            size: 27,
          ),
        ),
        hintText: 'Search for attractions...',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.8),
        ),
      ),
    );
  }
}
