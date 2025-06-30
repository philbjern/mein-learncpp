#include <iostream>
#include <string>

// T& is an lvalue reference, so this overload will be preferred for lvalues
template <typename T>
constexpr bool is_lvalue(T&)
{
	return true;
}

// T&& is an rvalue reference, so this overload will be preferred for rvalues
template <typename T>
constexpr bool is_lvalue(T&&)
{
	return false;
}

// A helper macro (#expr prints whatever is passed in for expr as text)
#define PRINTVCAT(expr) { std::cout << #expr << " is an " << (is_lvalue(expr) ? "lvalue\n" : "rvalue\n"); }

int getint() { return 5; }

int main()
{
	PRINTVCAT(5);		// rvalue
	PRINTVCAT(getint());	// rvalue
	int x { 5 };
	PRINTVCAT(x);
	PRINTVCAT(std::string { "Hello "});
	PRINTVCAT("Hello");
	PRINTVCAT(++x);
	PRINTVCAT(x++);
}
