import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycomplex_ui/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

const mockJsonResponse = '''
[
  {
    "date":"2024-07-01",
    "isPresent":true,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-02",
    "isPresent":false,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-03",
    "isPresent":true,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-04",
    "isPresent":true,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-15",
    "isPresent":true,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-18",
    "isPresent":false,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-24",
    "isPresent":true,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  },
  {
    "date":"2024-07-27",
    "isPresent":false,
    "checkInTime":"9:15 am",
    "checkOutTime":"5:23 pm"
  }
]
''';

class AttendanceHistoryScreen extends StatefulWidget {
  final Map<String,dynamic> maidDetails;
  final String selectedApartmentID;

  const AttendanceHistoryScreen({super.key, required this.maidDetails, required this.selectedApartmentID});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceHistoryScreenState createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  
CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool? isPresent; // True for present, False for absent, null for no data
  String? checkInTime;
  String? checkOutTime;
  final DateTime _firstAvailableDay = DateTime.now().subtract(const Duration(days: 30));
  late Map<DateTime, Map<String, dynamic>> attendanceData;

  @override
  void initState() {
    super.initState();
    _parseMockJsonResponse();
    _fetchAttendanceData(_focusedDay);
  }

  void _parseMockJsonResponse() {
    final List<dynamic> parsedList = jsonDecode(mockJsonResponse);
    attendanceData = {
      for (var item in parsedList)
        DateTime.parse(item['date']).toUtc(): {
          'isPresent': item['isPresent'],
          'checkInTime': item['checkInTime'],
          'checkOutTime': item['checkOutTime'],
        }
    };
  }

  void _fetchAttendanceData(DateTime date) {
    setState(() {
      DateTime dateWithoutTime = DateTime(date.year, date.month, date.day).toUtc();
      if (attendanceData.containsKey(dateWithoutTime)) {
        isPresent = attendanceData[dateWithoutTime]?['isPresent'];
        checkInTime = attendanceData[dateWithoutTime]?['checkInTime'];
        checkOutTime = attendanceData[dateWithoutTime]?['checkOutTime'];
      } else {
        isPresent = null;
        checkInTime = null;
        checkOutTime = null;
      }
    });
  }

  Color _getAttendanceColor(DateTime date) {
    DateTime dateWithoutTime = DateTime(date.year, date.month, date.day).toUtc();
    if (attendanceData.containsKey(dateWithoutTime)) {
      if (attendanceData[dateWithoutTime]?['isPresent'] == true) {
        return AppColors.presentColor;
      } else if (attendanceData[dateWithoutTime]?['isPresent'] == false) {
        return AppColors.absentColor;
      }
    }
    return AppColors.textColor;
  }

  FontWeight _getAttendanceFontWeight(DateTime date) {
    DateTime dateWithoutTime = DateTime(date.year, date.month, date.day).toUtc();
    if (attendanceData.containsKey(dateWithoutTime)) {
      if (attendanceData[dateWithoutTime]?['isPresent'] == true || attendanceData[dateWithoutTime]?['isPresent'] == false) {
        return FontWeight.bold;
      } 
    }
    return FontWeight.normal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        title: const Text('Attendance History', style: TextStyle(color: AppColors.onPrimary)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 4,),
          TableCalendar(
            calendarStyle: const CalendarStyle(cellPadding: EdgeInsets.all(4),tablePadding: EdgeInsets.all(4)),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              titleTextStyle: TextStyle(color: AppColors.onPrimary, fontSize: 20.0,),
              decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(10))),
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.chevron_left,color: AppColors.onPrimary,size: 28,),
              rightChevronIcon: Icon(Icons.chevron_right,color: AppColors.onPrimary,size: 28,),
            ),
            focusedDay: _focusedDay,
            firstDay: _firstAvailableDay,
            lastDay: DateTime.now(),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (selectedDay.isBefore(DateTime.now().subtract(const Duration(days: 30)))) return;
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _fetchAttendanceData(selectedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.onPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: _getAttendanceColor(day), fontWeight: _getAttendanceFontWeight(day),),
                    ),
                  ),
                );
              },
              disabledBuilder: (context, day, focusedDay) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(color: AppColors.textColor),
                    ),
                  ),
                );
              },
            ),
            enabledDayPredicate: (day) {
              return day.isAfter(_firstAvailableDay) && day.isBefore(DateTime.now().add(const Duration(days: 1)));
            },
          ),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat.yMMMd().format(_selectedDay!)}, Today',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.attendanceColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isPresent == true ? 'Present' : 'Absent',
                    style: TextStyle(
                      color: isPresent == true ? AppColors.presentColor : AppColors.absentColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.login, color: AppColors.textColor),
                          const SizedBox(width: 5),
                          Text(checkInTime ?? 'N/A'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(checkOutTime ?? 'N/A'),
                          const Icon(Icons.logout, color: AppColors.textColor),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'This log only indicates if the Daily Help entered the society, not if they came to your house.',
                    style: TextStyle(color: AppColors.textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}