#include <iostream>
#include <cctype>

using namespace std;

string clasificarCadena(const string& cadena) {
    bool tieneLetras = false, tieneNumeros = false;

    for (char c : cadena) {
        if (isdigit(c))
            tieneNumeros = true;
        else if (isalpha(c))
            tieneLetras = true;

        // Si tiene ambos, es compuesta
        if (tieneLetras && tieneNumeros)
            return "Compuesta";
    }

    if (tieneNumeros)
        return "Número entero";
    if (tieneLetras)
        return "Palabra";

    return "Desconocido"; // Para casos vacíos o caracteres especiales
}

int main() {
    string entrada;
    cout << "Ingrese una cadena: ";
    cin >> entrada;

    cout << "Clasificación: " << clasificarCadena(entrada) << endl;

    return 0;
}
