import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_demo/home/business_logic/theme_cubit/theme_mode_cubit.dart';
/*
class ChangeThemeMode extends StatelessWidget {
  const ChangeThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayThemeCubit, bool>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, showThemeChangeMenu) {
        return AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: showThemeChangeMenu ? 0 : MediaQuery.of(context).size.height,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: showThemeChangeMenu ? 0.6 : 0,
                  child: WillPopScope(
                    onWillPop: () async {
                      BlocProvider.of<DisplayThemeCubit>(context).hideThemeChange();
                      return false;
                    },
                    child: GestureDetector(
                        onTap: () =>  BlocProvider.of<DisplayThemeCubit>(context).hideThemeChange(),
                        child: Container(
                          color: Colors.black,
                          height: MediaQuery.of(context).size.height * 0.7,
                        )),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Dark Mode", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                      const Divider(),
                      RadioListTile<ThemeMode>(
                        title: const Text("Off"),
                        value: ThemeMode.light,
                        groupValue: BlocProvider.of<ThemeCubit>(context).state.mode,
                        onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.light),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text("On"),
                        value: ThemeMode.dark,
                        groupValue: BlocProvider.of<ThemeCubit>(context).state.mode,
                        onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.dark),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text("Use Device Settings"),
                        value: ThemeMode.system,
                        groupValue: BlocProvider.of<ThemeCubit>(context).state.mode,
                        onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.system),
                      )
                    ],
                  ),
                ),
              )
            ]
          )
        );
      },
    );
  }
}*/

class ChangeThemeMode extends StatelessWidget {
  const ChangeThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Dark Mode", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
              ),
              const Divider(thickness: 0.5,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 40),
                child: BlocBuilder<ThemeCubit, ThemeModeInfo>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile<ThemeMode>(
                          contentPadding: EdgeInsets.zero,
                            title: const Text("Off", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: ThemeMode.light,
                            groupValue: state.mode,
                            onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.light),
                            
                        ),
                        RadioListTile<ThemeMode>(
                          contentPadding: EdgeInsets.zero,
                            title: const Text("On", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: ThemeMode.dark,
                            groupValue: state.mode,
                            onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.dark),
                            
                        ),
                        RadioListTile<ThemeMode>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Use Device Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: ThemeMode.system,
                            groupValue: state.mode,
                            onChanged: (newThemeMode) => BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.system),
                          
                        )
                      ],
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
