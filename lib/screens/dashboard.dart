import 'package:expencetracker/constants/app_colors.dart';
import 'package:expencetracker/controller/transection_controller.dart';
import 'package:expencetracker/model/Transaction.dart';
import 'package:expencetracker/screens/detail_sceen.dart';
import 'package:expencetracker/utils/transection_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Controller
  final TransectionController _controller = Get.put(TransectionController());

  // Method to get recent transactions
  List<Transaction> getRecentTransactions() {
    List<Transaction> recentTransactions = [];
    
    // Get last two income transactions
    var incomeTransactions = _controller.getTransactions('Income');
    recentTransactions.addAll(incomeTransactions.reversed.take(2));

    // Get last two expense transactions
    var expenseTransactions = _controller.getTransactions('Expense');
    recentTransactions.addAll(expenseTransactions.reversed.take(2));

    return recentTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: Get.height * 0.25,
              width: Get.width * 0.90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() => Text(
                    _controller.totalbalance.value.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() => Text(
                            _controller.totalIncome.value.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expense",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() => Text(
                            _controller.totalExpense.value.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => DetailScreen());
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              var recentTransactions = getRecentTransactions();
              return ListView.builder(
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  var transaction = recentTransactions[index];
                  return Dismissible(
                    key: ValueKey(transaction), // Unique key for each item
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                     // Get the category
                      int transactionIndex = recentTransactions.indexOf(transaction); // Get the index

                      // Call the removeTransaction method with category and index
                     print("Hello");
                     // _controller.removeTransaction(transaction, index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${transaction.catagory} dismissed'),
                        ),
                      );
                    },
                    child: TransectionTile(
                      type: transaction.type,
                      amount: transaction.amount,
                      date: transaction.date,
                      category: transaction.catagory, onDismissed: (String category, DateTime date) {  },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
