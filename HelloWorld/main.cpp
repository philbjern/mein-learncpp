#include <iostream>

bool is_old_prick(int age) {
  return age > 30;
}

void ageist_greeing(int age) {
  if (is_old_prick(age)) {
    std::cout << "Hello you old prick, yer are "
    << age << " years old" << std::endl;
  } else {
    std::cout << "Hello, yer are " << age << " years old young buck" << std::endl;
  }
}

int main() 
{
  int age = 34;
  ageist_greeing(age);

  while (is_old_prick(age)) {
    std::cout << "Maybe we can do something about this..." << std::endl;
    age--;
    std::cout << "Looks like now, you are " << age << " years old, did we just go back in time??" << std::endl;
  }

  ageist_greeing(age);

  return 0;
}
