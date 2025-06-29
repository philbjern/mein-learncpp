#include <iostream>

int main()
{
	std::cout << "Enter a number: "; // ask user for a number

	int x {};    	  // define variable x to hold user input (and value-initialize it)
	std::cin >> x;    // get number from keyboard and store it in a variable x

	std::cout << "You entered " << x << '\n';
	return 0;
}
