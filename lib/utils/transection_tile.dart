import 'dart:ui';

import 'package:expencetracker/constants/app_colors.dart';
import 'package:expencetracker/model/catagory_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransectionTile extends StatefulWidget {
  final String category; // Updated to category
  final double amount;
  final DateTime date;
  final Function(String category, DateTime date) onDismissed; // Updated signature
  final String type;

  TransectionTile({
    super.key,
    required this.category, // Updated to category
    required this.amount,
    required this.date,
    required this.onDismissed, // Updated signature
    required this.type,
  });

  @override
  State<TransectionTile> createState() => _TransectionTileState();
}

class _TransectionTileState extends State<TransectionTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.category + widget.date.toString()), // Using category and date as key
      background: Container(
        height: Get.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Text(
              'Swipe to delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        // Call the onDismissed function with the correct parameters
        widget.onDismissed(widget.category, widget.date); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.category} dismissed')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Card(
          color: Colors.transparent,
          elevation: 20,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Use the icon based on the transaction category
                    Image.asset(
                      CategoryIcon.getIconForCategory(widget.type),
                      height: Get.height * 0.06,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.category,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.amount.toString(),
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.date),
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
