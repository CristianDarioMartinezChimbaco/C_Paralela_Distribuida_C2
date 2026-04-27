#include <iostream>
#include <thread>
#include <chrono>
#include <stdlib.h>
#include <cstdlib>

using namespace std;
using namespace chrono;
void crearDatosCobol(string name){
        auto inicio = high_resolution_clock::now();
        string comando = "cobc -x " + name + ".cob -o " + name;
        system(comando.c_str());
        comando = "./" + name; 
        system(comando.c_str());
        cout << "finalizo " << name << endl;
    auto fin = high_resolution_clock::now();
    auto duracion = duration_cast<milliseconds>(fin - inicio);
    cout << "Tiempo: " << duracion.count() << " ms" << endl;
}
void leerDatosCobol(string name){
    auto inicio = high_resolution_clock::now();
        string comando = "cobc -x " + name + ".cob -o " + name;
        system(comando.c_str());
        comando = "./" + name; 
        system(comando.c_str());
        cout << "finalizo " << name << endl;
    auto fin = high_resolution_clock::now();
    auto duracion = duration_cast<milliseconds>(fin - inicio);
    cout << "Tiempo: " << duracion.count() << " ms" << endl;
}

int main() {
    thread crearDatosCobol0(crearDatosCobol,"DATA-INDEX");
    thread crearDatosCobol1(leerDatosCobol,"INDEX");    
    crearDatosCobol0.join();
    crearDatosCobol1.join();
    cout << "Termino La creacion de todos los datos" << endl;  
    return 0;
}
