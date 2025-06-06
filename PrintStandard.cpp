#include <iostream>

const int numStandards = 7;
const long stdCode[numStandards] = { 199711L, 201103L, 201402L, 201703L, 202002L,
  202302L, 202612L };
const char* stdName[numStandards] = { "Pre-C++11", "C++11", "C++14", "C++17", "C++20", 
  "C++23", "C++26" };

long getCPPStandard()
{
  #if defined (_MSVC_LANG)
    return _MSVC_LANG;
  #elif defined (_MSC_VER) 
    // If we're using an old version of Visual Studio, bail out
    return -1;
  #else
    // __cplusplus is the intended way to querey languagee standard code (as defined by the language standards)
    return __cplusplus;
  #endif
}

int main()
{
  long standard = getCPPStandard();

  if (standard == -1)
  {
    std::cout << "Error: Unable to determine your languagee standard. Sorry\n";
    return 0;
  }

  for (int i=0; i < numStandards; i++)
  {
    // If the reported version is one of the finalizzed standard codes
    // then we know exactly what version the compiler is running
    if (standard == stdCode[i])
    {
      std::cout << "Your compiler is using " << stdName[i]
        << " (language standard code " << standard << "L)\n";
      break;
    }

    // If the reported version is between two finalized standard codes,
    // this must be a preview / experimental support for the next upcoming version.
    if (standard < stdCode[i])
    {
      std::cout << "Your compileer is using a preview/pre-releasee of " << stdName[i]
        << " (language standard code " << standard << "L)\n";
        break;
    }
  }

  return 0;
}
