# Flutter Multi-Screen Shell with Global Drawer Access

> Demonstrates how to open a parent drawer from any child screen in Flutter while maintaining BottomNavigationBar and avoiding nested scaffold issues.

---

## 🚀 Overview

In Flutter apps with multiple screens, it’s common to have a `Drawer` and a `BottomNavigationBar` shared across screens.  

Without proper architecture, developers often face:

- ❌ Bottom navigation disappearing  
- ❌ Nested Scaffold issues  
- ❌ Drawer not opening from child screens  

This project shows how to solve this using a **global scaffold key**, allowing any child screen to open the parent drawer safely.

---

## 🖼 Screenshots

### Before Fix (Nested Scaffold Problem)

 <img width="361" height="734" alt="Screenshot 2025-10-24 at 2 20 18 PM" src="https://github.com/user-attachments/assets/27d3790f-aaf8-419b-a806-18d4cff337c4" />


- `Scaffold.of(context).openDrawer()` tries to open the child scaffold  
- BottomNavigationBar may disappear  
- Drawer fails to open properly

### After Fix (GlobalKey Solution)

<img width="365" height="750" alt="Screenshot 2025-10-24 at 2 22 21 PM" src="https://github.com/user-attachments/assets/98c88eda-b872-4970-8af6-ecd0bf2fdcab" />


- Drawer opens from any child screen  
- BottomNavigationBar remains visible  
- Clean and centralized navigation

---

## 💡 Key Concepts

1. **Global Scaffold Key**
```dart
class AppConstants {
  static final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey<ScaffoldState>();
}
