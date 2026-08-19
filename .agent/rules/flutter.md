# Flutter & Dart - Core Rules

## 1. Principles
- **Everything is a Widget**: Every UI component should be a widget with a narrow responsibility.
- **Declarative UI**: UI reflects the current state. Avoid manual imperative UI updates.
- **Composition over Inheritance**: Prefer building complex widgets by composing simpler ones.
- **Hot Reload**: Leverage hot reload to iterate quickly.

## 2. Architecture: Feature-First Clean Architecture
- **Presentation Layer**: Widgets + Riverpod Providers.
- **Domain Layer**: Pure Dart Entities, Abstract Repositories, Use Cases. NO FLUTTER DEPENDENCIES.
- **Data Layer**: DTOs, Repository Implementations, Data Sources.
- **Dependency Injection**: Handled natively via `flutter_riverpod` providers.

## 3. Technology Stack
- **State Management**: flutter_riverpod with @riverpod code generation. NO Provider or GetX.
- **Local Storage**: `drift` (SQLite via `sqlite3`). FORBIDDEN: Sembast, Hive.
- **Map Engine**: flutter_map (v8.x) + latlong2.
- **Functional Programming**: fpdart for Either<Failure, Success>.

## 4. Dart Language
- **Strong Typing**: Sound null safety. Avoid dynamic.
- **Named Parameters**: Prefer for functions with >2 arguments.
- **Immutability**: Use @freezed for complex models.

## 5. Widget Guidelines
- **Small Widgets**: Extract complex build methods.
- **Const Constructors**: Use const where possible.
- **Keys**: Use keys for stateful widgets in lists.
- **Build Method**: Keep build() pure and side-effect free.
