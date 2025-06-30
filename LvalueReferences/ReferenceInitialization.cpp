#include <iostream>

int main() {
  // int& invalidRef;		// error: references must be initialized

  int x{5};
  int &ref{x}; // okay: reference to int is bound to int variable

  const int y{5};
  // int& invalidRef { y };	// invalid: non-const lvalue reference can't
  // bind to a non-modifiable lvalue int& invalidRef2 { 0 };	// invalid:
  // non-const lvalue reference can't bind to an rvalue

  return 0;
}
