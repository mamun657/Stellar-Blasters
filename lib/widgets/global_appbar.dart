import 'package:eco_city/services/auth_service.dart';
import 'package:flutter/material.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppbar({
    super.key,
    this.showBackBtn = false,
  });

  final bool showBackBtn;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset("assets/png/ecocity_appbar.png", height: 32),
      leading: showBackBtn ? _AppBarIconButton(iconData: Icons.arrow_back_ios, onTap: () => Navigator.pop(context)) : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black87),
          onPressed: () async {
            await AuthService().signOut();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;

  const _AppBarIconButton({required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Icon(iconData, size: 20));
  }
}