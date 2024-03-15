import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:section5/models/expense.dart';
import 'package:section5/expenses_list.dart';
import 'package:section5/models/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOvelLay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpanss(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text("No expenses found. Start Adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("ExpenseTracker Project"),
          ),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOvelLay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(children: [
          const Text("Your Expenses"),
          Expanded(child: mainContent)
        ]),
      ),
    );
  }
}
