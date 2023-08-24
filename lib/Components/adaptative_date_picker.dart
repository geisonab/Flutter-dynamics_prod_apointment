import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({
    super.key,
    this.selectedDate,
    required this.onDateChanged,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      onDateChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Platform.isIOS
          ? SizedBox(
              height: 80,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(2019),
                maximumDate: DateTime.now(),
                onDateTimeChanged: onDateChanged,
              ),
            )
          : SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate as DateTime)}',
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    onPressed: () => _showDatePicker(context),
                    child: const Text(
                      'Selecionar data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            );
    } catch (e) {
      return SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate as DateTime)}',
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)),
              onPressed: () => _showDatePicker(context),
              child: const Text(
                'Selecionar data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    }
  }
}
