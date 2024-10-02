import 'dart:math';


import 'package:expencetracker/database/database_helper.dart';
import 'package:expencetracker/model/my_transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransectionController  extends GetxController{
 final DatabaseHelper _dbHelper = DatabaseHelper();


RxList Income=<MyTransaction>[].obs;
RxList expense=<MyTransaction>[].obs;

RxDouble totalIncome=0.0.obs;

RxDouble totalExpense=0.0.obs;

RxDouble totalbalance=0.0.obs;

 RxString selectedCategory = 'Income'.obs;


// add a new transection
void addTransaction(String catagory,String type,double amount,DateTime date)


{

  MyTransaction mytransaction = MyTransaction(category: catagory,type: type,amount: amount,date: date,);
  if (catagory=='Income')
{
Income.add(mytransaction);
print("amoiunt add $amount");
totalIncome.value+=amount;
}else if(catagory=='Expense')
{
expense.add(mytransaction);
totalExpense.value+=amount;

}

totalbalance.value=totalIncome.value-totalExpense.value;
update();
_dbHelper.insertTransaction(mytransaction);
}



 void updateSelectedCategory(String category) {
    selectedCategory.value = category;
    update();  // Notify UI
  }


void removeTransaction(MyTransaction transaction, int index) {
  print("Methode called");
  if (transaction.category == 'Income') {
    print("Income");
    totalIncome.value -= transaction.amount;
    Income.remove(transaction);
     
  } else if (transaction.category == 'Expense') {
      totalExpense.value -= transaction.amount; 
    expense.remove(transaction);
  
  }

  // Update the total balance
  totalbalance.value = totalIncome.value - totalExpense.value;
  update(); // Notify the UI of the change
}



  //get list of specified category
List<MyTransaction> getTransactions(String category) {
    if (category == 'Income') {
      return List<MyTransaction>.from(Income); 
    } else if (category == 'Expense') {
      return List<MyTransaction>.from(expense); 
    }
    return [];
  }
}