%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int num_lineas = 0;
int num_palabras = 0;
int num_caracteres = 0;
int palabras_con_ni = 0;
int palabras_con_num = 0;
int palabras_b_to = 0;
int palabras_con_jo = 0;
int num_digitos = 0;

void verificar_palabra(char *palabra);
%}

DIGITO       [0-9]
LETRA        [A-Za-z¡…Õ”⁄·ÈÌÛ˙—Ò]
PALABRA      {LETRA}+
ESPACIO      [ \t\r]
SALTO_LINEA  \n

%%
{SALTO_LINEA} { num_lineas++; num_caracteres++; }
{ESPACIO}+    { num_caracteres += yyleng; }
{DIGITO}      { num_digitos++; num_caracteres++; num_palabras++; }
{PALABRA}     {
    num_palabras++;
    num_caracteres += yyleng;
    verificar_palabra(yytext);
}
.             { num_caracteres++; }
%%

void verificar_palabra(char *palabra) {
    int longitud = strlen(palabra);
    int i;  
    char *palabra_min = (char *)malloc(longitud + 1);
    
    if (!palabra_min) {
        perror("Error de memoria");
        exit(1);
    }
    
    
    for (i = 0; i < longitud; i++) {
        palabra_min[i] = tolower(palabra[i]);
    }
    palabra_min[longitud] = '\0';
    
    if (strncmp(palabra_min, "ni", 2) == 0) palabras_con_ni++;
    if (strncmp(palabra_min, "n˙m", 3) == 0) palabras_con_num++;
    
    if (palabra_min[0] == 'b' && longitud >= 3) {
        if (strcmp(palabra_min + longitud - 2, "to") == 0) {
            palabras_b_to++;
        }
    }
    
    if (longitud >= 2 && strcmp(palabra_min + longitud - 2, "jo") == 0) {
        palabras_con_jo++;
    }
    
    free(palabra_min);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            perror("Error al abrir el archivo");
            return 1;
        }
        yyin = archivo;
    }
    
    yylex();
    
    if (argc > 1) fclose(yyin);
    
    printf("\n=== RESULTADOS DEL AN¡LISIS ===\n");
    printf("Total de lÌneas: %d\n", num_lineas);
    printf("Total de palabras: %d\n", num_palabras);
    printf("Total de caracteres: %d\n", num_caracteres);
    printf("Palabras que comienzan con 'ni': %d\n", palabras_con_ni);
    printf("Palabras que comienzan con 'n˙m': %d\n", palabras_con_num);
    printf("Palabras que comienzan con 'b' y terminan con 'to': %d\n", palabras_b_to);
    printf("Palabras que terminan con 'jo': %d\n", palabras_con_jo);
    printf("DÌgitos numÈricos encontrados: %d\n", num_digitos);
    
    return 0;
}

int yywrap() {
    return 1;
}