#include <iostream>

int main()
{
	std::cout << "Enter two numbers separated by a space: ";

	int x{};
	int y{};
	std::cin >> x >> y;		// get two numbers and store in variable x and y respectively

	std::cout << "You entered " << x << " and " << y << '\n';

	return 0;
}
