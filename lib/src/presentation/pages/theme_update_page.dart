import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/config/theme/app_theme.dart';
import 'package:mera_bazaar/src/presentation/bloc/theme/theme_bloc.dart';

class ThemeUpdatePage extends StatelessWidget {
  const ThemeUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ThemeBloc, ThemeLoad>(
        builder: (context, stata) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(
                  UpdateThemeEvent(
                    themeData:
                        stata.themeData == AppTheme.lightTheme
                            ? AppTheme.darkTheme
                            : AppTheme.lightTheme,
                    isDark: stata.themeData != AppTheme.lightTheme,
                  ),
                );
              },
              child: const Text("Update Theme"),
            ),
          );
        },
      ),
    );
  }
}
