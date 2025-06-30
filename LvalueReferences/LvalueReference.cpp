#include <iostream>

int main() {
  int x{5};    // x is a normal integer variable
  int &ref{x}; // ref is an lvalue reference variable that can now be used as an
               // alias for variable x

  std::cout << x << '\n';   // print the value of x (5)
  std::cout << ref << '\n'; // print the value of x via ref (5)

  return 0;
}
