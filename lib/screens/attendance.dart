import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';



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
      appBar: AppBar(
        title: Text('Attendance'),
      ),
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
                colorList: [Colors.green, Colors.red],
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width / 3.5,
                centerText: "${totalPercentage.toStringAsFixed(1)}%",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index]),
                  subtitle: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100,
                    lineHeight: 20.0,
                    percent: subjectAttendance[index] / 100,
                    progressColor: Colors.green,
                    center: Text('${subjectAttendance[index]}%'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
