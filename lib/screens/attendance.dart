import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/colors.dart';

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
  List<double> subjectAttendance = [
    80.0,
    60.0,
    90.0
  ]; // Example subject-wise attendance percentages

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format the date using the 'dd MMMM yyyy' format
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Colors.blue,
                    blurRadius: 100.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0.0, 3.0,),
                  ),
                ],
                color: backgroundColor1.withOpacity(0.5),
                // border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                '$formattedDate',
                style: TextStyle(fontSize:20 , fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Colors.blue,
                    blurRadius: 100.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0.0, 5.0,),
                  ),
                ],

                color: backgroundColor1.withOpacity(0.6),
                // border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: PieChart(
                  dataMap: dataMap,
                  colorList: [Colors.greenAccent, Colors.red],
                  chartType: ChartType.ring,
                  chartRadius: MediaQuery.of(context).size.width / 3.5,
                  // centerText: "${totalPercentage.toStringAsFixed(1)}%",
                  centerWidget: Text(
                    "70.0%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValuesOutside: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: true,
                    chartValueBackgroundColor: Colors.white,
                    chartValueStyle: TextStyle(
                        color: backgroundColor, fontWeight: FontWeight.bold),
                  ),
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
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0), // Add margin vertically
                    child: ListTile(
                      tileColor: backgroundColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      title: Text(
                        subjects[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.normal,
                            color: Colors.lightBlueAccent.withOpacity(0.4),
                        blurRadius: 30.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0.0, 3.0,),
                      ),
                      ],
                        ),
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 73,
                          lineHeight: 20.0,
                          percent: subjectAttendance[index] / 100,
                          progressColor: Colors.lightBlueAccent,
                          backgroundColor: Colors.white,
                          center: Text('${subjectAttendance[index]}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
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
