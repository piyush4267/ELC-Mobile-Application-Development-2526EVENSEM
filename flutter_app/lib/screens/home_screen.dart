import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  final _cgpaController = TextEditingController();

  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _rollController.clear();
    _emailController.clear();
    _cgpaController.clear();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final student = Student(
      name: _nameController.text.trim(),
      rollNumber: _rollController.text.trim(),
      email: _emailController.text.trim(),
      cgpa: double.parse(_cgpaController.text.trim()),
    );

    final result = await _apiService.insertStudent(student);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              Text(result['message'] ?? 'Student added successfully!'),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(result['message'] ?? 'Failed to add student.')),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _showDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DetailsScreen()),
    );
  }

  // ✨ Displays the Project Developer Info Bottom Sheet Panel
  void _showProjectInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Keeps the underlying panel corners rounded
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 26),
                  const SizedBox(width: 10),
                  const Text(
                    'Project Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87), // Fixed typo
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 1),
              
              // Personal Profile Data Rows
              _buildInfoRow(Icons.person, 'Name', 'Piyush Anand'),
              _buildInfoRow(Icons.badge, 'Roll Number', '1025170118'),
              _buildInfoRow(Icons.account_tree_rounded, 'Branch', 'COPC'),
              _buildInfoRow(Icons.email, 'Email ID', 'panand_be25@thapar.edu'),
              
              const SizedBox(height: 16),
              const Text(
                'PROJECT PURPOSE',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Information Management App using Flutter and MySQL : An ELC Activity Semester : 2',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), // Fixed typo
                    ),
                    SizedBox(height: 4),
                    Text(
                      'This application has been developed as an assignment submission for the ELC activity for Semester 2 (2526 Even Sem) at Thapar Institute of Engineering & Technology (TIET). It demonstrates a cross-platform Flutter frontend that communicates with a backend MySQL database via PHP REST APIs hosted on an XAMPP server.',
                      style: TextStyle(fontSize: 12, height: 1.35, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Row formatter utility for student metadata rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 18),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54)),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))), // Fixed typo
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Student Registration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      // ✨ Floating Action Button configured to invoke the info modal drawer
      floatingActionButton: FloatingActionButton(
        onPressed: _showProjectInfo,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.info_outline),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card featuring Web-Safe Vertical Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6), // Bright Tech Blue (Top Center)
                    Color(0xFF1B365D), // Thapar Navy Anchor (Bottom Center)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.school, color: Colors.white, size: 36),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Student Information Management Application',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Fill the form to register yourself',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Full Name'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Piyush Anand',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                  ),

                  const SizedBox(height: 18),
                  _buildLabel('Roll Number'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _rollController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 1025000000',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Roll number is required' : null,
                  ),

                  const SizedBox(height: 18),
                  _buildLabel('Email ID'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'e.g. xyz@email.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email is required';
                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(v.trim())) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),
                  _buildLabel('CGPA'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _cgpaController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: 'e.g. 8.75  (0.0 – 10.0)',
                      prefixIcon: Icon(Icons.grade_outlined),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'CGPA is required';
                      final val = double.tryParse(v.trim());
                      if (val == null) return 'Enter a valid number';
                      if (val < 0 || val > 10) return 'CGPA must be between 0 and 10';
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Submit button - Points to crimson secondary color
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: colorScheme.secondary.withOpacity(0.6),
                    ),
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(_isLoading ? 'Submitting...' : 'Submit'),
                  ),

                  const SizedBox(height: 14),

                  // Show Details button
                  OutlinedButton.icon(
                    onPressed: _showDetails,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: colorScheme.primary, width: 1.5),
                      foregroundColor: colorScheme.primary,
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(Icons.list_alt_outlined),
                    label: const Text('Show Details'),
                  ),
                  const SizedBox(height: 60), // Extra bottom spacing padding so inputs are never blocked by the FAB
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }
}