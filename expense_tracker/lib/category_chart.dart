import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/get_sections_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PieChartCategory extends StatefulWidget {
  const PieChartCategory({super.key});

  @override
  State<PieChartCategory> createState() => _PieChartCategoryState();
}

class _PieChartCategoryState extends State<PieChartCategory> {
  int currDay = 0;
  int currMonth = 0;
  int currYear = 0;
  Map expense = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(listener: (context, state) {
      if (state is ExpenseLoaded) {
        expense = state.expenses;
      }
    }, builder: (context, state) {
      if (state is ExpenseLoaded) {
        expense = state.expenses;
        return Chartscategory(expense);
      }

      return Chartscategory(expense);
    });
  }

  SingleChildScrollView Chartscategory(Map expense) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              const Text(
                "Daily Expenses",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currDay < expense["groupByDay"].length - 1) {
                          setState(() {
                            currDay++;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                    iconSize:
                        currDay < expense["groupByDay"].length - 1 ? 30 : 24,
                    color: currDay < expense["groupByDay"].length - 1
                        ? Colors.purple
                        : Colors.purple[200],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    formatDate(expense["groupByDay"][currDay][0]),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    onPressed: () {
                      if (currDay > 0) {
                        setState(() {
                          currDay--;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.chevron_right,
                      color: currDay > 0 ? Colors.purple : Colors.purple[200],
                    ),
                    iconSize: currDay > 0 ? 30 : 24,
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: PieChart(
                      PieChartData(
                        sections: getSections(currDay, "groupByDay", expense),
                        centerSpaceRadius: 0,
                        sectionsSpace: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.blueAccent,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              const Text(
                "Monthly Expenses",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currMonth < expense["groupByMonth"].length - 1) {
                          setState(() {
                            currMonth++;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                    iconSize: currMonth < expense["groupByMonth"].length - 1
                        ? 30
                        : 24,
                    color: currMonth < expense["groupByMonth"].length - 1
                        ? Colors.purple
                        : Colors.purple[200],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    formatMonth(expense["groupByMonth"][currMonth][0]),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    onPressed: () {
                      if (currMonth > 0) {
                        setState(() {
                          currMonth--;
                        });
                      }
                    },
                    icon: const Icon(Icons.chevron_right),
                    color: currMonth > 0 ? Colors.purple : Colors.purple[200],
                    iconSize: currMonth > 0 ? 30 : 24,
                  )
                ],
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: PieChart(
                  PieChartData(
                    sections: getSections(currMonth, "groupByMonth", expense),
                    centerSpaceRadius: 0,
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              const Text(
                "Annual Expenses",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currYear < expense["groupByYear"].length - 1) {
                          setState(() {
                            currYear++;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                    color: currYear < expense["groupByYear"].length - 1
                        ? Colors.purple
                        : Colors.purple[200],
                    iconSize:
                        currYear < expense["groupByYear"].length - 1 ? 30 : 24,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    formatYear(expense["groupByYear"][currYear][0]),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    onPressed: () {
                      if (currYear > 0) {
                        setState(() {
                          currYear--;
                        });
                      }
                    },
                    icon: const Icon(Icons.chevron_right),
                    color: currYear > 0 ? Colors.purple : Colors.purple[200],
                    iconSize: currYear > 0 ? 30 : 24,
                  )
                ],
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: PieChart(
                  PieChartData(
                    sections: getSections(currYear, "groupByYear", expense),
                    centerSpaceRadius: 0,
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    print("i am the date -############# $date");
    String formattedDate = DateFormat('MMMM d, y').format(date);

    return formattedDate;
  }

  String formatMonth(DateTime date) {
    String formattedDate = DateFormat('MMMM y').format(date);

    return formattedDate;
  }

  String formatYear(DateTime date) {
    String formattedDate = DateFormat('y').format(date);
    return formattedDate;
  }
}