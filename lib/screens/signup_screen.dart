import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/logo_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  // password helpers
  String _passwordStrengthLabel = '';
  Color _passwordStrengthColor = Colors.grey;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordState);
    _confirmPasswordController.addListener(_updateMatchState);
  }

  void _updatePasswordState() {
    final pwd = _passwordController.text;
    final lengthOk = pwd.length >= 8;
    final upperOk = RegExp(r'[A-Z]').hasMatch(pwd);
    final numberOk = RegExp(r'\d').hasMatch(pwd);
    final specialOk = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd);

    final score =
        (lengthOk ? 1 : 0) +
        (upperOk ? 1 : 0) +
        (numberOk ? 1 : 0) +
        (specialOk ? 1 : 0);

    if (pwd.isEmpty) {
      _passwordStrengthLabel = '';
      _passwordStrengthColor = Colors.grey;
    } else if (score <= 1) {
      _passwordStrengthLabel = 'Strength: Weak';
      _passwordStrengthColor = Colors.red;
    } else if (score == 2) {
      _passwordStrengthLabel = 'Strength: Medium';
      _passwordStrengthColor = Colors.orange;
    } else {
      _passwordStrengthLabel = 'Strength: Strong';
      _passwordStrengthColor = Colors.green;
    }

    _updateMatchState();
    setState(() {});
  }

  void _updateMatchState() {
    _passwordsMatch =
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
    setState(() {});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signUpWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // ✅ Navigate to home after successful sign-up
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  InputDecoration _pillDecoration({required Widget prefix}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.green.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      prefixIcon: Padding(padding: const EdgeInsets.all(8.0), child: prefix),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // more rectangular (was 30)
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _smallIconCircle(IconData icon) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white,
      child: Icon(icon, size: 16, color: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // set background to white
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 4),
              const LogoWidget(),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: _pillDecoration(
                              prefix: _smallIconCircle(Icons.person),
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Enter first name'
                                : null,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: _pillDecoration(
                              prefix: _smallIconCircle(Icons.person_outline),
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Enter last name'
                                : null,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: _pillDecoration(
                        prefix: _smallIconCircle(Icons.email),
                      ).copyWith(hintText: 'abc@gmail.com'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _pillDecoration(
                        prefix: _smallIconCircle(Icons.lock),
                      ).copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    if (_passwordStrengthLabel.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _passwordStrengthLabel,
                          style: TextStyle(
                            color: _passwordStrengthColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: _pillDecoration(
                        prefix: _smallIconCircle(Icons.lock_outline),
                      ).copyWith(hintText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _passwordsMatch
                              ? Icons.check_circle
                              : Icons.info_outline,
                          color: _passwordsMatch ? Colors.green : Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _passwordsMatch
                              ? 'Password Matched'
                              : 'Password requirements',
                          style: TextStyle(
                            color: _passwordsMatch
                                ? Colors.green
                                : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _requirementRow(
                          '8 characters at least',
                          _passwordController.text.length >= 8,
                        ),
                        _requirementRow(
                          '1 uppercase letter',
                          RegExp(r'[A-Z]').hasMatch(_passwordController.text),
                        ),
                        _requirementRow(
                          '1 number',
                          RegExp(r'\d').hasMatch(_passwordController.text),
                        ),
                        _requirementRow(
                          '1 special character',
                          RegExp(
                            r'[!@#$%^&*(),.?":{}|<>]',
                          ).hasMatch(_passwordController.text),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200, // reduced width for a smaller button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _isLoading ? null : _signUp,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.lock, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Terms & Conditions',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requirementRow(String text, bool ok) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.circle,
            size: 14,
            color: ok ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: ok ? Colors.green : Colors.black54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
