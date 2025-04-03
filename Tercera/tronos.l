%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Estructura para almacenar frecuencias
typedef struct {
    char *nombre;
    int contador;
} Elemento;

// Lugares de Juego de Tronos
Elemento lugares[] = {
    {"Westeros", 0},
    {"Invernalia", 0},
    {"Desembarco del Rey", 0},
    {"Nido de Águilas", 0},
    {"Altojardín", 0},
    {"Aguasdulces", 0},
    {"Rocadragón", 0},
    {"Roca Casterly", 0},
    {"Bastión de Tormentas", 0},
    {"Dorne", 0},
    {NULL, 0}
};

// Casas principales
Elemento casas[] = {
    {"Stark", 0},
    {"Arryn", 0},
    {"Tully", 0},
    {"Greyjoy", 0},
    {"Lannister", 0},
    {"Tyrell", 0},
    {"Martell", 0},
    {"Baratheon", 0},
    {"Targaryen", 0},
    {NULL, 0}
};

// Personajes principales (incluyendo apodos y nombres alternativos)
Elemento personajes[] = {
    // Casa Stark
    {"Eddard", 0}, {"Ned", 0}, {"Catelyn", 0}, {"Arya", 0}, {"Sansa", 0}, {"Bran", 0}, {"Robb", 0}, {"Rickon", 0},
    // Casa Baratheon
    {"Robert", 0}, {"Joffrey", 0}, {"Stannis", 0}, {"Renly", 0},
    // Casa Targaryen
    {"Aegon", 0}, {"Daenerys", 0}, {"Viserys", 0}, {"Aerys", 0},
    // Casa Lannister
    {"Tywin", 0}, {"Jaime", 0}, {"Tyrion", 0}, {"Cersei", 0},
    // Otras casas
    {"Jon", 0}, {"Snow", 0}, {"Petyr", 0}, {"Littlefinger", 0}, {"Varys", 0}, {"Sandor", 0}, {"Gregor", 0},
    {NULL, 0}
};

// Función para incrementar contadores
void incrementar_contador(Elemento *lista, char *texto) {
    int i;  // Declaración fuera del for para compatibilidad
    for (i = 0; lista[i].nombre != NULL; i++) {
        if (strstr(texto, lista[i].nombre) != NULL) {
            lista[i].contador++;
        }
    }
}

%}

%%
[a-zA-ZáéíóúÁÉÍÓÚñÑ]+ {
    // Busca en cada palabra del texto
    char *palabra = yytext;
    incrementar_contador(lugares, palabra);
    incrementar_contador(casas, palabra);
    incrementar_contador(personajes, palabra);
}
.|\n {} // Ignorar otros caracteres
%%

int main(int argc, char *argv[]) {
    int i;  // Declaración fuera de los bucles
    
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_de_texto>\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yyin = archivo;
    yylex(); // Ejecuta el análisis léxico

    // Imprime resultados
    printf("=== FRECUENCIAS EN 'JUEGO DE TRONOS' ===\n");

    printf("\n** Lugares **\n");
    for (i = 0; lugares[i].nombre != NULL; i++) {
        printf("%-20s: %d\n", lugares[i].nombre, lugares[i].contador);
    }

    printf("\n** Casas **\n");
    for (i = 0; casas[i].nombre != NULL; i++) {
        printf("%-20s: %d\n", casas[i].nombre, casas[i].contador);
    }

    printf("\n** Personajes **\n");
    for (i = 0; personajes[i].nombre != NULL; i++) {
        printf("%-20s: %d\n", personajes[i].nombre, personajes[i].contador);
    }

    fclose(archivo);
    return 0;
}