#include <iostream>

extern "C" int _add(int a, int b);

int main() {
    int num1 = 5;
    int num2 = 10;
    int result = _add(num1, num2);

    std::cout << "The sum of " << num1 << " and " << num2 << " is " << result << std::endl;
    return 0;
}
