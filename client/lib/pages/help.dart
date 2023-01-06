import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;
  bool isCompleted = false;
  var isLastStep = false;
  @override
  Widget build(BuildContext context) {
    return isCompleted
        ? buildCompleted()
        : Theme(
            data: Theme.of(context)
                .copyWith(colorScheme: ColorScheme.light(primary: Colors.red)),
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: _currentStep,
              onStepTapped: ((step) {
                setState(() {
                  _currentStep = step;
                });
              }),
              onStepContinue: () {
                isLastStep = _currentStep == getSteps().length - 1;
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                  });
                } else {
                  setState(() => _currentStep += 1);
                }
              },
              onStepCancel: () {
                _currentStep == 0 ? null : setState(() => _currentStep -= 1);
              },
              controlsBuilder: (BuildContext, ControlsDetails) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: ControlsDetails.onStepContinue,
                        child: Text(isLastStep ? "Confirm" : "Next"),
                      ),
                      if (_currentStep != 0)
                        TextButton(
                          onPressed: ControlsDetails.onStepCancel,
                          child: const Text("Last"),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  List<Step> getSteps() => [
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: Text('Account'),
          content: Container(),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: Text('Address'),
          content: Container(),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: Text('Complete'),
          content: Container(),
        ),
      ];

  Widget buildCompleted() {
    return ElevatedButton(
      child: Text("hello"),
      onPressed: () {
        setState(() {});
        isLastStep = false;
        isCompleted = false;
        _currentStep = 0;
      },
    );
  }
}
