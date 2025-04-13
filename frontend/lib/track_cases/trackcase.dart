import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() => runApp(CaseStatusApp());

class CaseStatusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Case Status',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xFF003366),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: CaseStatusScreen(),
    );
  }
}

class CaseStatusScreen extends StatefulWidget {
  @override
  _CaseStatusScreenState createState() => _CaseStatusScreenState();
}

class _CaseStatusScreenState extends State<CaseStatusScreen> {
  String selectedLanguage = 'English';
  bool isSubscribed = false;

  void _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Padding(
              padding: pw.EdgeInsets.all(20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Case Status",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text("Petitioner vs Respondent"),
                  pw.Text("District Court, XYZ"),
                  pw.SizedBox(height: 10),
                  pw.Text("Case No: 1000/2023 • Registered On 06-12-2023"),
                  pw.Text("Last Presented On: 15-12-2023"),
                  pw.Text("Case Status: WON\nJudges: Hon'ble Mr. Sharma"),
                  pw.Text("Category: Criminal • Sec 305"),
                  pw.Text("Petitioner(s): Rakesh Aggarwal"),
                  pw.Text("Respondent(s): State of XYZ"),
                  pw.Text("Pet. Advocates: Adv. Mohan"),
                  pw.Text("Res. Advocates: Adv. Suman"),
                ],
              ),
            ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Widget _subscribeCard() {
    return Card(
      color: Colors.white12,
      child: ListTile(
        leading: const Icon(
          Icons.notifications_active,
          color: Color(0xFF00B9F1),
        ),
        title: const Text(
          'Subscribe to Updates',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Receive hearing dates, orders, and status.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSubscribed ? Colors.green : Color(0xFF00B9F1),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isSubscribed = !isSubscribed;
            });
          },
          child: Text(isSubscribed ? 'Subscribed' : 'Subscribe'),
        ),
      ),
    );
  }

  Widget _helpCard() {
    return Card(
      color: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.help_outline, color: Color(0xFF00B9F1)),
        title: const Text(
          'Need Legal Help?',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          'Connect with verified legal aid services.',
          style: TextStyle(color: Colors.white60),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00B9F1),
            foregroundColor: Colors.white,
          ),
          child: const Text('Get Help'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Status", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedLanguage = value;
              });
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'English', child: Text('English')),
                  PopupMenuItem(value: 'Hindi', child: Text('हिन्दी')),
                ],
            icon: Icon(Icons.language, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                title: Text(
                  "Petitioner vs Respondent",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("District Court, XYZ"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // View attachment action
              },
              child: Text("View Attachments"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            HorizontalStepper(
              currentStep: 2,
              steps: [
                'Filling',
                'Hearing',
                'Arguments',
                'Judgement Reserved',
                'Disposed',
              ],
            ),
            const SizedBox(height: 20),
            Text(
              selectedLanguage == 'Hindi' ? "मामले का विवरण" : "Case Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            const SizedBox(height: 10),
            DetailRow(
              label: selectedLanguage == 'Hindi' ? "मामला संख्या:" : "Case No:",
              value: "1000/2023 • Registered On 06-12-2023",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "अंतिम प्रस्तुति:"
                      : "Last Presented On:",
              value: "15-12-2023",
            ),
            DetailRow(
              label: selectedLanguage == 'Hindi' ? "स्थिति:" : "Case Status:",
              value: "WON\nJudges: Hon'ble Mr. Sharma",
            ),
            DetailRow(
              label: selectedLanguage == 'Hindi' ? "श्रेणी:" : "Category:",
              value: "Criminal • Sec 305",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "याचिकाकर्ता:"
                      : "Petitioner(s):",
              value: "Rakesh Aggarwal",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi' ? "प्रतिवादी:" : "Respondent(s):",
              value: "State of XYZ",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "याचिकाकर्ता के वकील:"
                      : "Pet. Advocates:",
              value: "Adv. Mohan",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "प्रतिवादी के वकील:"
                      : "Res. Advocates:",
              value: "Adv. Suman",
            ),
            const SizedBox(height: 20),
            _subscribeCard(),
            const SizedBox(height: 10),
            _helpCard(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _generatePdf,
                  icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                  label: Text(
                    "Download PDF",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF003366),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF003366),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    selectedLanguage == 'Hindi'
                        ? "मुखपृष्ठ पर लौटें"
                        : "Back to Home",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class HorizontalStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const HorizontalStepper({required this.currentStep, required this.steps});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep;
          final isLast = index == steps.length - 1;

          return Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor:
                        isActive ? Color(0xFF003366) : Colors.grey[300],
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 70,
                    child: Text(
                      steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: isActive ? Color(0xFF003366) : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Container(
                  width: 30,
                  height: 2,
                  color: isActive ? Color(0xFF003366) : Colors.grey[300],
                ),
            ],
          );
        }),
      ),
    );
  }
}
