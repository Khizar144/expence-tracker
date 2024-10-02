import 'package:expencetracker/constants/app_colors.dart';
import 'package:expencetracker/controller/transection_controller.dart';
import 'package:expencetracker/utils/toggle.dart';
import 'package:expencetracker/utils/transection_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TransectionController _controller = Get.put(TransectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){

          Get.back();
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text(
          "Transaction",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.basicColor,
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.01),
            Center(
              child: IncomeExpenseToggle(),  // Wrapping in Center or Align to make sure it's visible
            ),
            SizedBox(height: Get.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMMM').format(DateTime.now()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                // Display total amount dynamically based on the selected category
                Obx(() {
                  final selectedCategory = _controller.selectedCategory.value;
                  final totalAmount = selectedCategory == 'Income'
                      ? _controller.totalIncome.value
                      : _controller.totalExpense.value;

                  return Text(
                    "RS$totalAmount",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  );
                }),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              // Show the list of transactions based on the selected category
              child: Obx(() {
                final selectedCategory = _controller.selectedCategory.value;
                final transactions = selectedCategory == 'Income'
                    ? _controller.getTransactions('Income')
                    : _controller.getTransactions('Expense');

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    
                    return TransectionTile(
                    type: transaction.type,
                    amount: transaction.amount,
                    date: transaction.date,
                    category: transaction.category,
                    onDismissed: (String type, DateTime date) {
                    _controller.removeTransaction(transaction, index);
                    }, 
                  );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
