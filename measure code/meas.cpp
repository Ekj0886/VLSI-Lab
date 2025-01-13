#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(){

    fstream outfile("meas.txt", ios_base::out);

    if(outfile.is_open()) {
        int r_t, f_t;
        string name;
        cout << "Enter: signal_name rise_num fall_num" << endl;
        while(cin >> name >> r_t >> f_t){
            for(int i = 1; i <= r_t; i++){
                outfile << ".meas tran rise_" << i << name << " trig v(" << name << ") val='supply*0.1' rise=" << i << endl;
                outfile << "+targ v(" << name << ") val='supply*0.9' rise=" << i << '\n' << endl;

            }/*
            for(int i = 1; i <= f_t; i++){
                outfile << ".meas tran fall_" << i << name << " trig v(" << name << ") val='supply*0.9' fall=" << i << endl;
                outfile << "+targ v(" << name << ") val='supply*0.1' fall=" << i << '\n' << endl;
            }outfile << endl;*/
        }
    }else{
        cout << "fail" << endl;
    }
}
