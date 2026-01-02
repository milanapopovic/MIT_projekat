import 'package:flutter/material.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:const Text(
          'Fashion Store',
          style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 22,
          letterSpacing: 1,
            ),
          ),

      ),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
       Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF8E6C88).withAlpha(26),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: const Color(0xFF8E6C88).withAlpha(89),
        ),
      ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_outline, color: Color(0xFF8E6C88), size: 20),
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
              border: Border.all(color: const Color(0xFF8E6C88).withAlpha(40)),
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
                  backgroundColor: const Color(0xFF8E6C88).withAlpha(30),
                  child: const Icon(Icons.person, color: Color(0xFF8E6C88)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Milana Popovic',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'popovicmilana123@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

           Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'General',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8E6C88),
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF8E6C88).withAlpha(40),
                ),
              ),
              child: Column(
                children: [
                  _ProfileRow(
                    icon: Icons.shopping_cart_outlined,
                    title: 'All Orders',
                    onTap: () {
                      
                    },
                  ),
                  const Divider(height: 1),
                  _ProfileRow(
                    icon: Icons.bookmark_border,
                    title: 'Wishlist',
                    onTap: () {
                     
                    },
                  ),
                  const Divider(height: 1),
                  _ProfileRow(
                    icon: Icons.person_outline,
                    title: 'Edit profile',
                    onTap: () {
                     
                    },
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Logout dugme
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Center(
              child: SizedBox(
                width: 180,
                height: 46,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF8E6C88),
                    backgroundColor: const Color(0xFF8E6C88).withAlpha(18),
                    side: BorderSide(
                      color: const Color(0xFF8E6C88).withAlpha(90),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
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
    const brand = Color(0xFF8E6C88);

    return ListTile(
      leading: Icon(icon, color: brand),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.chevron_right, color: brand.withAlpha(150)),
      onTap: onTap,
    );
  }
}



      
   