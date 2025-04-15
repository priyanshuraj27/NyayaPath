import 'package:flutter/material.dart';
import 'package:frontend/legalaid/legalaidhome.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:frontend/components/home_screen.dart';
void main() => runApp(CaseStatusApp());

class CaseStatusApp extends StatelessWidget {
  const CaseStatusApp({super.key});

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
  const CaseStatusScreen({super.key});

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
                  pw.Text("M. Siddiq (D) Thr Lrs vs Mahant Suresh Das & Ors"),
                  pw.Text("Supreme Court of India"),
                  pw.SizedBox(height: 10),
                  pw.Text("Case No: Civil Appeal Nos. 10866–10867/2010"),
                  pw.Text("Last Presented On: 06-08-2019"),
                  pw.Text(
                    "Case Status: DISPOSED (Verdict: Ram Mandir construction allowed)",
                  ),
                  pw.Text("Judges: Hon’ble CJI Ranjan Gogoi and others"),
                  pw.Text("Category: Civil • Land Dispute"),
                  pw.Text("Petitioner(s): M. Siddiq (D) Thr Lrs"),
                  pw.Text("Respondent(s): Mahant Suresh Das & Ors"),
                  pw.Text("Pet. Advocates: Adv. Rajeev Dhavan"),
                  pw.Text("Res. Advocates: Adv. C.S. Vaidyanathan"),
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
          onPressed: () {
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LegalAidScreen()),
      );
          },
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                title: Text(
                  "M. Siddiq (D) Thr Lrs vs Mahant Suresh Das & Ors",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Supreme Court of India"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("View Attachments"),
            ),
            const SizedBox(height: 10),
            HorizontalStepper(
              currentStep: 4,
              steps: [
                'Filing',
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
              value: "Civil Appeal Nos. 10866–10867/2010",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "अंतिम प्रस्तुति:"
                      : "Last Presented On:",
              value: "06-08-2019",
            ),
            DetailRow(
              label: selectedLanguage == 'Hindi' ? "स्थिति:" : "Case Status:",
              value:
                  "DISPOSED (Verdict: Ram Mandir construction allowed)\nJudges: Hon’ble CJI Ranjan Gogoi and others",
            ),
            DetailRow(
              label: selectedLanguage == 'Hindi' ? "श्रेणी:" : "Category:",
              value: "Civil • Land Dispute",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "याचिकाकर्ता:"
                      : "Petitioner(s):",
              value: "M. Siddiq (D) Thr Lrs",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi' ? "प्रतिवादी:" : "Respondent(s):",
              value: "Mahant Suresh Das & Ors",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "याचिकाकर्ता के वकील:"
                      : "Pet. Advocates:",
              value: "Adv. Rajeev Dhavan",
            ),
            DetailRow(
              label:
                  selectedLanguage == 'Hindi'
                      ? "प्रतिवादी के वकील:"
                      : "Res. Advocates:",
              value: "Adv. C.S. Vaidyanathan",
            ),
            const SizedBox(height: 20),
            _subscribeCard(),
            const SizedBox(height: 10),
            _helpCard(),
            const SizedBox(height: 20),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
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

  const DetailRow({super.key, required this.label, required this.value});

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

  const HorizontalStepper({super.key, required this.currentStep, required this.steps});

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
                  SizedBox(
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
