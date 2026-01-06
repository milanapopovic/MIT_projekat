import 'package:fashion_app1/auth/auth_state.dart';
import 'package:fashion_app1/constants/app_colors.dart';
import 'package:fashion_app1/screens/auth/auth_screen.dart';
import 'package:fashion_app1/screens/profile/edit_profile_screen.dart';
import 'package:fashion_app1/screens/profile/orders_screen.dart';
import 'package:fashion_app1/screens/profile/wishlist_screen.dart';
import 'package:fashion_app1/widgets/brand_app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();   
    final bool isGuest = auth.isGuest;     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:const BrandAppBarTitle(title: 'Fashion Store'),


      ),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
       Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.brandSoft,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color:AppColors.brandSoftBorder,
        ),
      ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_outline, color:AppColors.brand, size: 20),
            SizedBox(width: 8),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    ),



         
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.brandLine,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.brand.withAlpha(30),
                  child: const Icon(Icons.person, color:AppColors.brand),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isGuest ? 'Guest user' : 'Milana Popovic',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isGuest ? 'Please login or register' : (auth.email ?? ''),
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isGuest) ...[

  Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
    child: Text(
      'General',
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: AppColors.brand,
        letterSpacing: 0.6,
      ),
    ),
  ),

  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.brandLine),
      ),
      child: Column(
        children: [
          _ProfileRow(
            icon: Icons.shopping_cart_outlined,
            title: 'All Orders',
            onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersScreen()),
            );
            },
          ),
          const Divider(height: 1),
          _ProfileRow(
            icon: Icons.bookmark_border,
            title: 'Wishlist',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),
          const Divider(height: 1),
          _ProfileRow(
            icon: Icons.person_outline,
            title: 'Edit profile',
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          initialName: 'Milana Popovic',
          initialEmail: auth.email ?? '',
        ),
      ),
    );
            },
          ),
        ],
      ),
    ),
  ),
],


          const Spacer(),

          // Logout dugme
         Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 46,
                child: isGuest
                    ? ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AuthScreen()),
                          );
                        },
                        child: const Text('Login / Register'),
                      )
                    : OutlinedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                         style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.brandSoft,
                          foregroundColor: AppColors.brand,
                          side: BorderSide(
                            color: AppColors.brandBorder,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        
                        ),
                        onPressed: () async {
                          context.read<AuthState>().logout(); 

                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const AuthScreen()),
                            (route) => false,
                          );
                        },
                      ),
              ),
            ),
          ),



          
          const SizedBox(height: 0),
        ],
      ),
    );
  }
}
class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileRow({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.brand),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.brand.withAlpha(150)),
      onTap: onTap,
    );
  }
}



      
   