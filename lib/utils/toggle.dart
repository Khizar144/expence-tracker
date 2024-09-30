import 'package:expencetracker/controller/transection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeExpenseToggle extends StatelessWidget {
  final TransectionController transectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ToggleButtons(
          isSelected: [
            transectionController.selectedCategory.value == 'Income',
            transectionController.selectedCategory.value == 'Expense',
          ],
          borderRadius: BorderRadius.circular(10),
          renderBorder: false,
          fillColor: Colors.transparent,
          onPressed: (index) {
            // Update the selected category in the controller
            transectionController.updateSelectedCategory(
              index == 0 ? 'Income' : 'Expense',
            );
          },
          children: [
            // Income Button
            AnimatedContainer(
              duration: Duration(milliseconds: 900),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: transectionController.selectedCategory.value == 'Income'
                    ? LinearGradient(
                        colors: [Colors.blue, Colors.purple, Colors.pink],
                      )
                    : null,
              ),
              child: Text(
                'Income',
                style: TextStyle(
                  color: transectionController.selectedCategory.value == 'Income'
                      ? Colors.white
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Expenses Button
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: transectionController.selectedCategory.value == 'Expense'
                    ? LinearGradient(
                        colors: [Colors.blue, Colors.purple, Colors.pink],
                      )
                    : null,
              ),
              child: Text(
                'Expenses',
                style: TextStyle(
                  color: transectionController.selectedCategory.value == 'Expense'
                      ? Colors.white
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
