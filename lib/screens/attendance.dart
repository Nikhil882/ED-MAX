import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../utils/colors.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Map<String, double> dataMap = {
    'Attended': 70.0,
    'Absent': 30.0,
  };
  double totalPercentage = 70.0; // Calculate total percentage here

  List<String> subjects = ['Math', 'Science', 'English']; // Example subjects
  List<double> subjectAttendance = [80.0, 60.0, 90.0]; // Example subject-wise attendance percentages

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${DateTime.now().toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: PieChart(
                dataMap: dataMap,
                colorList: [Colors.greenAccent, Colors.red],
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width / 3.5,
               // centerText: "${totalPercentage.toStringAsFixed(1)}%",
                centerWidget:Text(
                  "70.0%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ) ,

                legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValues: false,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Subject-wise Attendance:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subjects[index],
                    style: TextStyle(
                      color: Colors.white,


                    )),
                    subtitle: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 100,
                      lineHeight: 20.0,
                      percent: subjectAttendance[index] / 100,
                      progressColor: Colors.blue,
                      center: Text('${subjectAttendance[index]}%'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
