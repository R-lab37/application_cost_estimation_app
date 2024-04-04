import 'package:flutter/material.dart';

void main() {
  runApp(AppCostCalculator());
}

class AppCostCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController developerRateController = TextEditingController();
  TextEditingController developerHoursController = TextEditingController();
  TextEditingController baseCostController = TextEditingController();
  TextEditingController additionalFeaturesCostController =
      TextEditingController();
  TextEditingController multiplierController = TextEditingController();

  int totalCost = 0;

  void calculateCost() {
    double developerRate = double.tryParse(developerRateController.text) ?? 0;
    int developerHours = int.tryParse(developerHoursController.text) ?? 0;
    double baseCost = double.tryParse(baseCostController.text) ?? 0;
    double additionalFeaturesCost =
        double.tryParse(additionalFeaturesCostController.text) ?? 0;
    double multiplier = double.tryParse(multiplierController.text) ?? 1;

    setState(() {
      totalCost = ((baseCost + additionalFeaturesCost) * multiplier).round();
      if (developerRate != 0 && developerHours != 0) {
        totalCost = (developerRate * developerHours).round();
      }
    });
  }

  void showUserGuide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Guide'),
          content: SingleChildScrollView(
            child: Text(
                '''The formula for calculating app development cost can vary depending on several factors, including the complexity of the app, the hourly rate of developers, the number of features/screens, and additional expenses such as design, testing, and maintenance.

However, a basic formula often used to estimate app development cost is:

Total Cost = Developer Rate × Developer Hours

where:
- Developer Rate: The hourly rate of the developer or development team.
- Developer Hours: The estimated number of hours required to develop the app.

Sometimes, this formula is expanded to include additional factors:

Total Cost = (Base Cost + Additional Features Cost) × Multiplier

where:
- Base Cost: The cost for the core features of the app.
- Additional Features Cost: The cost for any extra features or complexity beyond the base features.
- Multiplier: A factor applied to adjust for various aspects such as complexity, platform (iOS, Android, both), overheads, and profit margin.

It's important to note that estimating app development cost is not always straightforward and can vary significantly based on project requirements, developer rates, geographic location, and other factors. Therefore, it's often best to consult with development professionals or firms to get a more accurate estimate for a specific project.'''),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Cost Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: developerRateController,
                decoration: InputDecoration(
                  labelText: 'Developer Rate (₹)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: developerHoursController,
                decoration: InputDecoration(
                  labelText: 'Developer Hours',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: baseCostController,
                decoration: InputDecoration(
                  labelText: 'Base Cost (₹)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: additionalFeaturesCostController,
                decoration: InputDecoration(
                  labelText: 'Additional Features Cost (₹)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: multiplierController,
                decoration: InputDecoration(
                  labelText: 'Multiplier',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: calculateCost,
                child: Text('Calculate Cost'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: showUserGuide,
                child: Text('User Guide'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Cost: ₹ $totalCost',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
