import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/user_bloc/user_bloc.dart';
import '../../logic/user_bloc/user_state.dart';
import '../widgets/user_shimmer.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Stack Resilience'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<UserCubit>().fetchUsers(),
          )
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          // 1. LOADING
          if (state is UserLoading) return const UserShimmer();

          // 2. ERROR
          if (state is UserError) {
            return _buildCenteredInfo(
              icon: Icons.cloud_off,
              color: Colors.red,
              title: "¡Ups! Algo salió mal",
              subtitle: state.errorMessage,
              onAction: () => context.read<UserCubit>().fetchUsers(),
              actionLabel: "Reintentar",
            );
          }

          // 3. EMPTY
          if (state is UserEmpty) {
            return _buildCenteredInfo(
              icon: Icons.Inbox_outlined,
              color: Colors.orange,
              title: "Sin registros",
              subtitle: "La API respondió con una lista vacía.",
              onAction: () => context.read<UserCubit>().fetchUsers(),
              actionLabel: "Actualizar",
            );
          }

          // 4. SUCCESS
          if (state is UserSuccess) {
            return RefreshIndicator(
              onRefresh: () => context.read<UserCubit>().fetchUsers(),
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(user.name[0])),
                      title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCenteredInfo({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onAction,
    required String actionLabel,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: color.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}