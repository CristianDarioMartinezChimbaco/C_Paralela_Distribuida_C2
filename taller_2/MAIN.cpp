#include <iostream>
#include <thread>
#include <chrono>
#include <stdlib.h>
#include <cstdlib>

using namespace std;
using namespace chrono;
void crearDatosCobol(string name){
        auto inicio = high_resolution_clock::now();
        string comando = "cobc -x CREAR-DATOS" + name + ".cob -o CREAR-DATOS" + name;
        system(comando.c_str());
        comando = "./CREAR-DATOS" + name; 
        system(comando.c_str());
        cout << "finalizo CREAR-DATOS" << name << endl;
    auto fin = high_resolution_clock::now();
    auto duracion = duration_cast<milliseconds>(fin - inicio);
    cout << "Tiempo: " << duracion.count() << " ms" << endl;
}
void leerDatosCobol(string name){
    auto inicio = high_resolution_clock::now();
        string comando = "cobc -x LEER-DATOS" + name + ".cob -o LEER-DATOS" + name;
        system(comando.c_str());
        comando = "./LEER-DATOS" + name; 
        system(comando.c_str());
        cout << "finalizo LEER-DATOS" << name << endl;
    auto fin = high_resolution_clock::now();
    auto duracion = duration_cast<milliseconds>(fin - inicio);
    cout << "Tiempo: " << duracion.count() << " ms" << endl;
}

int main() {
    thread crearDatosCobol0(crearDatosCobol,"0");
    thread crearDatosCobol1(crearDatosCobol,"1");
    thread crearDatosCobol2(crearDatosCobol,"2");
    thread crearDatosCobol3(crearDatosCobol,"3");
    thread crearDatosCobol4(crearDatosCobol,"4");
    crearDatosCobol0.join();
    crearDatosCobol1.join();
    crearDatosCobol2.join();
    crearDatosCobol3.join();
    crearDatosCobol4.join();
    cout << "Termino La creacion de todos los datos" << endl;
    thread leerDatosCobol0(leerDatosCobol,"0");
    thread leerDatosCobol1(leerDatosCobol,"1");
    thread leerDatosCobol2(leerDatosCobol,"2");
    thread leerDatosCobol3(leerDatosCobol,"3");
    thread leerDatosCobol4(leerDatosCobol,"4");
    leerDatosCobol0.join();
    leerDatosCobol1.join();
    leerDatosCobol2.join();
    leerDatosCobol3.join();
    leerDatosCobol4.join();
    return 0;
}
