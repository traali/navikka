---
description: Create a new Flutter component with standard structure (Widget + Provider + Test)
---

# Workflow: Create Component

1. Ask the user for the component name (e.g., \"WeatherBadge\") and the feature area (e.g., \"weather\").
2. Create the Widget file in lib/features/{{feature_area}}/presentation/widgets/{{component_name}}_widget.dart.
3. Create the Provider file in lib/features/{{feature_area}}/presentation/providers/{{component_name}}_provider.dart.
4. Create a basic Unit/Widget test in 	est/features/{{feature_area}}/presentation/widgets/{{component_name}}_widget_test.dart.
5. Run code generation:
   `ash
   dart run build_runner build --delete-conflicting-outputs
   `
6. Ask the user to review the scaffolded files.
