#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cctype>

// Función para verificar si una cadena es un número
bool esNumero(const std::string& str) {
    for (size_t i = 0; i < str.length(); ++i) {
        if (!isdigit(str[i])) return false;
    }
    return true;
}

// Función para verificar si una cadena es una palabra (solo letras)
bool esPalabra(const std::string& str) {
    for (size_t i = 0; i < str.length(); ++i) {
        if (!isalpha(str[i])) return false;
    }
    return true;
}

// Función para verificar si una cadena es combinada (letras y números)
bool esCombinada(const std::string& str) {
    bool tieneLetra = false;
    bool tieneNumero = false;
    for (size_t i = 0; i < str.length(); ++i) {
        if (isalpha(str[i])) tieneLetra = true;
        if (isdigit(str[i])) tieneNumero = true;
    }
    return tieneLetra && tieneNumero;
}

int main() {
    // Nombre del archivo de entrada
    std::string nombreArchivo = "entrada.txt";

    // Leer el archivo de texto
    std::ifstream archivoEntrada(nombreArchivo.c_str()); // Usar c_str() para convertir a const char*

    // Verificar si el archivo se abrió correctamente
    if (!archivoEntrada.is_open()) {
        std::cerr << "Error: No se pudo abrir el archivo " << nombreArchivo << std::endl;
        return 1; // Termina el programa con un código de error
    }

    std::string linea;
    std::vector<std::string> lexemas;
    int totalCaracteresConEspacios = 0;
    int totalCaracteresSinEspacios = 0;
    int totalLexemas = 0;
    int totalPalabras = 0;
    int totalNumeros = 0;
    int totalCombinadas = 0;

    // Leer el archivo línea por línea
    while (std::getline(archivoEntrada, linea)) {
        totalCaracteresConEspacios += linea.length();
        std::string lexema;
        for (size_t i = 0; i < linea.length(); ++i) {
            char c = linea[i];
            if (!isspace(c)) {
                lexema += c;
                totalCaracteresSinEspacios++;
            } else {
                if (!lexema.empty()) {
                    lexemas.push_back(lexema);
                    lexema.clear();
                }
            }
        }
        if (!lexema.empty()) {
            lexemas.push_back(lexema);
        }
    }

    archivoEntrada.close();

    totalLexemas = lexemas.size();

    // Clasificar los lexemas
    for (size_t i = 0; i < lexemas.size(); ++i) {
        const std::string& lex = lexemas[i];
        if (esNumero(lex)) {
            totalNumeros++;
        } else if (esPalabra(lex)) {
            totalPalabras++;
        } else if (esCombinada(lex)) {
            totalCombinadas++;
        }
    }

    // Imprimir los resultados
    std::cout << "=== Resultados ===" << std::endl;
    std::cout << "Total de caracteres (con espacios): " << totalCaracteresConEspacios << std::endl;
    std::cout << "Total de caracteres (sin espacios): " << totalCaracteresSinEspacios << std::endl;
    std::cout << "Total de lexemas: " << totalLexemas << std::endl;
    std::cout << "Total de palabras: " << totalPalabras << std::endl;
    std::cout << "Total de números: " << totalNumeros << std::endl;
    std::cout << "Total de combinadas: " << totalCombinadas << std::endl;

    return 0;
}
