#include <iostream>

int main() {
  int x{5};
  int &ref{x};

  std::cout << x << ref << '\n'; // prints 55

  x = 6; // x now has value 6

  std::cout << x << ref << '\n'; // prints 66

  ref = 7; // the object being referenced (x) now has value 7

  std::cout << x << ref << '\n'; // prints 77

  return 0;
}
