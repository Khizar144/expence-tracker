import 'dart:math';

import 'package:expencetracker/model/Transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransectionController  extends GetxController{


RxList Income=<Transaction>[].obs;
RxList expense=<Transaction>[].obs;

RxDouble totalIncome=0.0.obs;

RxDouble totalExpense=0.0.obs;

RxDouble totalbalance=0.0.obs;

 RxString selectedCategory = 'Income'.obs;


// add a new transection
void addTransaction(String catagory,String type,double amount,DateTime date)


{

  Transaction transaction = Transaction(catagory: catagory,type: type,amount: amount,date: date, category: '');
  if (catagory=='Income')
{
Income.add(transaction);
print("amoiunt add "+amount.toString());
totalIncome.value+=amount;
}else if(catagory=='Expense')
{
expense.add(transaction);
totalExpense.value+=amount;

}

totalbalance.value=totalIncome.value-totalExpense.value;
update();

}



 void updateSelectedCategory(String category) {
    selectedCategory.value = category;
    update();  // Notify UI
  }


void removeTransaction(Transaction transaction, int index) {
  print("Methode called");
  if (transaction.catagory == 'Income') {
    print("Income");
    totalIncome.value -= transaction.amount;
    Income.remove(transaction);
     // Subtract the removed amount from total Income
  } else if (transaction.catagory == 'Expense') {
      totalExpense.value -= transaction.amount; 
    expense.remove(transaction);
  // Subtract the removed amount from total Expense
  }

  // Update the total balance
  totalbalance.value = totalIncome.value - totalExpense.value;
  update(); // Notify the UI of the change
}



  //get list of specified category
List<Transaction> getTransactions(String category) {
    if (category == 'Income') {
      return List<Transaction>.from(Income); // Convert RxList to List<Transaction>
    } else if (category == 'Expense') {
      return List<Transaction>.from(expense); // Convert RxList to List<Transaction>
    }
    return [];
  }
}