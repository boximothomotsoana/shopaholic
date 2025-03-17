import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookingCalendar(),
    );
  }
}

class BookingCalendar extends StatefulWidget {
  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _bookings = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor Bookings')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) => _bookings[day] ?? [],
          ),
          if (_selectedDay != null)
            Expanded(
              child: ListView(
                children: (_bookings[_selectedDay!] ?? [])
                    .map((booking) => ListTile(title: Text(booking)))
                    .toList(),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (_selectedDay != null) {
                setState(() {
                  _bookings[_selectedDay!] = [
                    ...(_bookings[_selectedDay!] ?? []),
                    'New Booking at ${_selectedDay!.toLocal()}'
                  ];
                });
              }
            },
            child: Text('Add Booking'),
          ),
        ],
      ),
    );
  }
}
