import 'package:flutter/material.dart';

class CaseAssignScreen extends StatefulWidget {
  @override
  _CaseAssignScreenState createState() => _CaseAssignScreenState();
}

class _CaseAssignScreenState extends State<CaseAssignScreen>
    with SingleTickerProviderStateMixin {
  String selectedCaseType = 'Criminal';
  String caseNumber = '';
  String assignedJudge = '';
  bool _isLoading = false;
  List<String> assignmentHistory = [];
  double confidenceScore = 0.0;
  late AnimationController _animationController;

  final Map<String, IconData> caseIcons = {
    'Criminal': Icons.local_police,
    'Civil': Icons.people,
    'Corporate': Icons.business,
    'Family': Icons.family_restroom,
  };

  final List<Map<String, dynamic>> judges = [
    {
      'name': 'Hon’ble Justice A. K. Sharma',
      'specializations': ['Criminal', 'Civil'],
      'caseload': 3,
      'available': true,
      'avatarUrl': 'assets/images/judge1.jpg',
    },
    {
      'name': 'Hon’ble Justice Meera Nair',
      'specializations': ['Corporate', 'Civil'],
      'caseload': 2,
      'available': true,
      'avatarUrl': 'assets/images/judge2.jpg',
    },
    {
      'name': 'Hon’ble Justice R. K. Patel',
      'specializations': ['Criminal'],
      'caseload': 1,
      'available': false,
      'avatarUrl': 'assets/images/judge3.jpg',
    },
    {
      'name': 'Hon’ble Justice Leela Sinha',
      'specializations': ['Family', 'Civil'],
      'caseload': 4,
      'available': true,
      'avatarUrl': 'assets/images/judge4.jpg',
    },
    {
      'name': 'Hon’ble Justice Arvind Menon',
      'specializations': ['Corporate'],
      'caseload': 2,
      'available': false,
      'avatarUrl': 'assets/images/judge5.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void assignCase({String? overrideJudge}) async {
    if (caseNumber.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid Case Number")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      confidenceScore = 0.0;
    });

    await Future.delayed(Duration(seconds: 1));

    if (overrideJudge != null) {
      setState(() {
        assignedJudge = overrideJudge;
        confidenceScore = 1.0;
        assignmentHistory.insert(
          0,
          "Case $caseNumber → $assignedJudge (Manual)",
        );
        _isLoading = false;
        _animationController.forward(from: 0.0);
      });
      return;
    }

    final availableJudges =
        judges
            .where(
              (j) =>
                  j['specializations'].contains(selectedCaseType) &&
                  j['available'] == true,
            )
            .toList();

    availableJudges.sort((a, b) => a['caseload'].compareTo(b['caseload']));

    setState(() {
      if (availableJudges.isNotEmpty) {
        assignedJudge = availableJudges.first['name'];
        confidenceScore = 0.8 + (1 / (availableJudges.first['caseload'] + 1));
        assignmentHistory.insert(
          0,
          "Case $caseNumber → $assignedJudge "
          "(${(confidenceScore * 100).toInt()}%)",
        );
      } else {
        assignedJudge = 'No suitable judge available';
      }
      _isLoading = false;
      _animationController.forward(from: 0.0);
    });
  }

  void _showJudgeList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C3A8C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        String localSearchQuery = '';
        bool localShowAvailableOnly = false;

        return StatefulBuilder(
          builder: (context, modalSetState) {
            final filteredJudges =
                judges.where((judge) {
                  final nameMatch = judge['name'].toLowerCase().contains(
                    localSearchQuery.toLowerCase(),
                  );
                  final availableMatch =
                      !localShowAvailableOnly || judge['available'] == true;
                  return nameMatch && availableMatch;
                }).toList();

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search judge by name",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF101336),
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged:
                        (val) => modalSetState(() {
                          localSearchQuery = val;
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Only",
                        style: TextStyle(color: Colors.white),
                      ),
                      Switch(
                        value: localShowAvailableOnly,
                        onChanged:
                            (val) => modalSetState(
                              () => localShowAvailableOnly = val,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredJudges.length,
                    itemBuilder: (context, index) {
                      final judge = filteredJudges[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          assignCase(overrideJudge: judge['name']);
                        },
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(judge['avatarUrl']),
                        ),
                        title: Text(
                          judge['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Specialties: ${judge['specializations'].join(', ')} | Caseload: ${judge['caseload']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Icon(
                          Icons.circle,
                          color: judge['available'] ? Colors.green : Colors.red,
                          size: 12,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final caseIcon = caseIcons[selectedCaseType] ?? Icons.balance;

    return Scaffold(
      backgroundColor: const Color(0xFF101336),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C3A8C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(caseIcon, size: 40, color: Color(0xFF101336)),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    "Auto Case Assigner",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onChanged: (value) => caseNumber = value,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter Case Number",
                      labelStyle: TextStyle(color: Color(0xFFC3C6D1)),
                      filled: true,
                      fillColor: Color(0xFF2C3A8C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedCaseType,
                    dropdownColor: Color(0xFF2C3A8C),
                    decoration: InputDecoration(
                      labelText: "Select Case Type",
                      labelStyle: TextStyle(color: Color(0xFFC3C6D1)),
                      filled: true,
                      fillColor: Color(0xFF2C3A8C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged:
                        (value) => setState(() => selectedCaseType = value!),
                    items:
                        caseIcons.keys
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(caseIcons[type], color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      type,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00B9F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isLoading ? null : () => assignCase(),
                      child:
                          _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                "Assign Case",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (assignedJudge.isNotEmpty)
                    FadeTransition(
                      opacity: _animationController,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2C3A8C),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Assigned Judge: $assignedJudge",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (confidenceScore > 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Confidence Score: ${(confidenceScore * 100).toInt()}%",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: _showJudgeList,
                                child: Text(
                                  "Reassign",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),
                  TextButton(
                    onPressed: _showJudgeList,
                    child: Text(
                      "Show All Judges",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Assignment History",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...assignmentHistory.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        entry,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
