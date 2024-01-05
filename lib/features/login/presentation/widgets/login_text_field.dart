import '/src/app_export.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.inputType,
    this.isPassword = false,
    required this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  final bool isPassword;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    bool obscurePassword = true;
    return Container(
      height: 71,
      width: 470,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.greyOp100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextFormField(
            controller: controller,
            keyboardType: inputType,
            textAlignVertical: TextAlignVertical.center,
            obscureText: isPassword ? obscurePassword : false,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: const Color(0xFFC3C3C3),
              ),
              suffixIcon: isPassword
                  ? InkWell(
                      onTap: () => setState(() {
                        obscurePassword = !obscurePassword;
                      }),
                      child: Icon(
                        obscurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 20,
                        color: obscurePassword
                            ? const Color(0xFFC3C3C3)
                            : AppColors.yellowOp100,
                      ),
                    )
                  : null,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: AppTextStyles.font16BlackMedium.copyWith(
                color: const Color(0xFFC3C3C3),
              ),
            ),
          );
        },
      ),
    );
  }
}
