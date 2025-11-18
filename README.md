# booking_demo_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Architecture

### Clean Architecture Implementation
The project follows clean architecture with three main layers:

1. **Presentation Layer** (`lib/presentation/`)
   - Pages, widgets, and state managers
   - Uses Signals Flutter for state management
   - Auto Route for navigation
   - **Atomic Design Pattern** for UI component organization

2. **Domain Layer** (`lib/domain/`)
   - Business logic, entities, repositories interfaces, and use cases
   - Independent of external frameworks

3. **Data Layer** (`lib/data/`)
   - API services, models, and repository implementations
   - Network layer with Dio client and interceptors

### Atomic Design Pattern
The presentation layer implements Atomic Design methodology for scalable and maintainable UI components:

1. **Atoms** (`lib/presentation/atomic/atoms/`)
   - Basic building blocks (buttons, inputs, icons, text, images)
   - Cannot be broken down further without losing functionality
   - Examples: CustomButton, TextInput, IconButton, AppText
   - **Guidelines**: Should be pure, reusable, and highly composable

2. **Molecules** (`lib/presentation/atomic/molecules/`)
   - Simple groups of atoms functioning together
   - Examples: SearchBar (input + icon), FormField (label + input + error)
   - **Guidelines**: Should perform a single, well-defined function

3. **Organisms** (`lib/presentation/atomic/organisms/`)
   - Complex components built from molecules and/or atoms
   - Examples: NavigationBar, UserProfile, BookCard, CommentSection
   - **Guidelines**: Can contain business logic and state management

4. **Templates** (`lib/presentation/atomic/templates/`)
   - Page-level layouts that combine organisms
   - Define the structure without specific content
   - Examples: DashboardTemplate, ReaderTemplate, AuthTemplate
   - **Guidelines**: Focus on layout and positioning, not content

5. **Pages** (`lib/presentation/pages/`)
   - Specific instances of templates with real data
   - Connect to providers/state managers
   - Handle navigation and route parameters
   - **Guidelines**: Minimal logic, delegate to providers and use cases

### Key Architectural Patterns
- **Dependency Injection**: Uses `get_it` with `injectable` for DI
- **State Management**: `signals_flutter` for reactive state
- **Routing**: `auto_route` for type-safe navigation
- **API**: Dio with custom interceptors for auth and error handling
- **Error Handling**: Custom failures with `fpdart` Either type

## Project Structure

```
lib/
├── core/                           # Core utilities and services
│   ├── constants/                  # API and app constants
│   ├── di/                        # Dependency injection setup
│   ├── error/                     # Error handling and exceptions
│   ├── network/                   # Dio client and interceptors
│   ├── routes/                    # Auto-generated routes
│   ├── services/                  # Core services (notifications, auth)
│   └── utils/                     # Utilities and preferences
├── data/                          # Data layer
│   ├── datasources/               # API services
│   ├── models/                    # Data models with Freezed
│   └── repositories/              # Repository implementations
├── domain/                        # Business logic layer
│   ├── entities/                  # Business entities
│   ├── repositories/              # Repository interfaces
│   └── usecases/                  # Business use cases
├── features/                      # Feature modules (domain-specific)
│   ├── auth/                      # Authentication feature
│   ├── reader/                    # E-book reader feature
│   ├── library/                   # Book library feature
│   └── profile/                   # User profile feature
└── presentation/                  # UI layer (Atomic Design)
    ├── atomic/                    # Atomic Design components
    │   ├── atoms/                 # Basic UI elements
    │   │   ├── buttons/           # Button components
    │   │   ├── inputs/            # Input fields
    │   │   ├── icons/             # Icon components
    │   │   ├── text/              # Text components
    │   │   ├── images/            # Image components
    │   │   ├── avatars/           # Avatar components
    │   │   ├── badges/            # Badge components
    │   │   ├── dividers/          # Divider components
    │   │   └── loaders/           # Loading indicators
    │   ├── molecules/             # Composite components
    │   │   ├── cards/             # Card components
    │   │   ├── forms/             # Form components
    │   │   ├── list_items/        # List item components
    │   │   ├── navigation/        # Navigation components
    │   │   ├── search/            # Search components
    │   │   └── dialogs/           # Dialog components
    │   ├── organisms/             # Complex components
    │   │   ├── headers/           # Header sections
    │   │   ├── footers/           # Footer sections
    │   │   ├── sidebars/          # Sidebar sections
    │   │   ├── tables/            # Table components
    │   │   ├── forms/             # Complex forms
    │   │   ├── lists/             # Complex lists
    │   │   └── modals/            # Modal dialogs
    │   └── templates/             # Page templates
    │       ├── layouts/           # Layout templates
    │       └── screens/           # Screen templates
    ├── pages/                     # Actual screens/pages
    ├── providers/                 # State managers (Signals)
    └── widgets/                   # Legacy/shared widgets
```

## Key Dependencies and Usage

### Core Dependencies
- **flutter_smart_dialog**: For dialogs and overlays
- **auto_route**: Type-safe routing with code generation
- **get_it + injectable**: Dependency injection
- **signals_flutter**: Reactive state management
- **dio**: HTTP client with interceptors
- **freezed + json_annotation**: Immutable models with JSON serialization

### Code Generation Dependencies
Run code generation after modifying:
- Freezed models (`*.freezed.dart`)
- JSON serializable models (`*.g.dart`) 
- Injectable dependencies (`injection.config.dart`)
- Auto Route routes (`app_router.gr.dart`)

### Testing
- Unit tests in `test/` directory
- Widget tests for UI components
- Use `fvm flutter test` if Flutter Version Management is configured

## Development Guidelines

### Code Style
- Follows `flutter_lints` rules with customizations in `analysis_options.yaml`
- Disabled const constructor preferences for flexibility
- Uses Freezed for immutable data classes
- Implements proper null safety

### UI Component Development (Atomic Design)

#### Component Organization Guidelines
1. **Atoms**: Place in appropriate subdirectory by type
   - Keep atoms stateless when possible
   - Use theme data for styling consistency
   - Accept parameters for customization
   - Example: `lib/presentation/atomic/atoms/buttons/primary_button.dart`

2. **Molecules**: Combine 2-3 atoms for specific functionality
   - Should have a single, clear purpose
   - Can manage internal state if needed
   - Example: `lib/presentation/atomic/molecules/forms/text_field_with_label.dart`

3. **Organisms**: Build complex, reusable sections
   - Can contain business logic
   - May connect to providers for state
   - Example: `lib/presentation/atomic/organisms/headers/app_bar_with_search.dart`

4. **Templates**: Define page layouts
   - Use placeholders for dynamic content
   - Focus on responsive design
   - Example: `lib/presentation/atomic/templates/layouts/main_layout.dart`

5. **Pages**: Implement specific screens
   - Connect templates with real data
   - Handle navigation and routing
   - Minimal UI logic, delegate to providers
   - Example: `lib/presentation/pages/home/home_page.dart`

#### Naming Conventions
- **Atoms**: `{component_type}_{variant}.dart` (e.g., `button_primary.dart`, `text_heading.dart`)
- **Molecules**: `{component_name}.dart` (e.g., `search_bar.dart`, `user_avatar_with_name.dart`)
- **Organisms**: `{section_name}.dart` (e.g., `navigation_drawer.dart`, `book_grid.dart`)
- **Templates**: `{page_name}_template.dart` (e.g., `reader_template.dart`)
- **Pages**: `{page_name}_page.dart` (e.g., `home_page.dart`, `book_details_page.dart`)

#### Component Reusability Rules
- **Atoms**: 100% reusable across the entire app
- **Molecules**: Should be reusable in multiple contexts
- **Organisms**: May be feature-specific but designed for reuse
- **Templates**: Reusable layouts for similar page types
- **Pages**: Specific implementations, not reused

### State Management
- Use `signals_flutter` for reactive state
- State managers in `lib/presentation/providers/`
- Business logic in use cases, not in UI
- Connect state to organisms and pages, not atoms or molecules

### API Integration
- All API services extend `BaseApiService`
- Use `DioClient` for HTTP requests with auth and error interceptors
- Implement proper error handling with custom failures

### Navigation
- Use `auto_route` for type-safe navigation
- Routes defined in `lib/core/routes/app_router.dart`
- Regenerate routes after modifications

### Asset Management
- SVG icons in `assets/svg/`
- Images in `assets/image/`
- Korean fonts (NotoSansKR) configured
- Environment variables in `.env`
