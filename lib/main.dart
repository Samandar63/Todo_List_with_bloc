import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app_bloc/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo_app_bloc/screens/tabs_screen.dart';
import 'package:todo_app_bloc/services/app_route.dart';
import 'package:todo_app_bloc/services/app_themes.dart';
import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  runApp(MyApp(
    appRoute: AppRoute(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});
  final AppRoute appRoute;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Todo List",
            debugShowCheckedModeBanner: false,
            theme: state.swithchValue
                ? AppThemes.appTheme[AppTheme.darkTheme]
                : AppThemes.appTheme[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRoute.onGenerateRoute,
          );
        },
      ),
    );
  }
}
