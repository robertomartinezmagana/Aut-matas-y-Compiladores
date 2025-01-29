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
        return "N�mero entero";
    if (tieneLetras)
        return "Palabra";

    return "Desconocido"; // Para casos vac�os o caracteres especiales
}

int main() {
    string entrada;
    cout << "Ingrese una cadena: ";
    cin >> entrada;

    cout << "Clasificaci�n: " << clasificarCadena(entrada) << endl;

    return 0;
}
