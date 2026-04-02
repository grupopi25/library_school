import 'package:flutter/material.dart';

class HeaderAdmin extends StatelessWidget {
  const HeaderAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, 
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xff2563EB)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0xff6B7280)),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      hintStyle: TextStyle(color: Color(0xff6B7280)),
                    
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                        

                        
                      ),
                      
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16), 
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
                color: Color(0xff64748B),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Admin', style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff191C1E))),
                  Text('User',
                      style: TextStyle(fontSize: 12, color: Color(0xff64748B))),
                ],
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('A', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}