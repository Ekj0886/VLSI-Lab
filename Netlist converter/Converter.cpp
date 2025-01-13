#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
using namespace std;

int main() {
    std::vector<std::string> names;
    std::ifstream ifs("input.txt", std::ios::in);
    if (!ifs.is_open()) {
        cout << "Failed to open file.\n";
    } else {
        std::string s;
        while (std::getline(ifs, s)) {



            cout << s << "\n";
            //names.push_back(s);
        }
        ifs.close();
    }
    ifs.close();
    return 0;
}
