/******************************************************************************

                              Online C++ Compiler.
               Code, Compile, Run and Debug C++ program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <iostream>
#include <sstream>
#include <cctype>

using namespace std;

string clasificarCadena(const string& cadena) {
    bool tieneLetras = false, tieneNumeros = false;

    for (char c : cadena) {
        if (isdigit(c))
            tieneNumeros = true;
        else if (isalpha(c))
            tieneLetras = true;

        if (tieneLetras && tieneNumeros)
            return "Compuesta";
    }

    if (tieneNumeros)
        return "Número entero";
    if (tieneLetras)
        return "Palabra";

    return "Desconocido"; // En caso de caracteres especiales o vacío
}

int main() {
    string linea, palabra;
    int countEntero = 0, countPalabra = 0, countCompuesta = 0;

    cout << "Ingrese una línea de texto: ";
    getline(cin, linea);  // Leer toda la línea

    stringstream ss(linea);
    
    while (ss >> palabra) {
        string tipo = clasificarCadena(palabra);
        if (tipo == "Número entero") countEntero++;
        else if (tipo == "Palabra") countPalabra++;
        else if (tipo == "Compuesta") countCompuesta++;
    }

    cout << countEntero << " - entero, " << countPalabra << " palabra, " << countCompuesta << " compuesta" << endl;

    return 0;
}