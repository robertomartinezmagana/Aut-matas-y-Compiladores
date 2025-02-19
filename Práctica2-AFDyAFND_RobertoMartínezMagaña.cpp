#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_N 100
#define MAX_S 100
#define MAX_C 100

int transition[MAX_N + 1][256]; // Tabla de transiciones
int accepting[MAX_N + 1]; // Estados de aceptación

int main() {
    int N, S, D, q0, T, C;
    char buffer[512];
    
    // Leer la primera línea completa y parsearla
    fgets(buffer, sizeof(buffer), stdin);
    sscanf(buffer, "%d %d %d %d %d %d", &N, &S, &D, &q0, &T, &C);
    
    char alphabet[S];
    fgets(buffer, sizeof(buffer), stdin);
    strcpy(alphabet, buffer);
    alphabet[strcspn(alphabet, "\n")] = 0; // Eliminar salto de línea
    
    memset(accepting, 0, sizeof(accepting));
    fgets(buffer, sizeof(buffer), stdin);
    char *token = strtok(buffer, " ");
    while (token != NULL) {
        int state = atoi(token);
        accepting[state] = 1;
        token = strtok(NULL, " ");
    }
    
    memset(transition, -1, sizeof(transition));
    for (int i = 0; i < D; i++) {
        int I, J;
        char X;
        fgets(buffer, sizeof(buffer), stdin);
        sscanf(buffer, "%d %c %d", &I, &X, &J);
        transition[I][(int)X] = J;
    }
    
    for (int i = 0; i < C; i++) {
        char input[101];
        fgets(input, sizeof(input), stdin);
        input[strcspn(input, "\n")] = 0; // Eliminar salto de línea
        
        int current_state = q0;
        for (int j = 0; input[j] != '\0'; j++) {
            current_state = transition[current_state][(int)input[j]];
            if (current_state == -1) break;
        }
        
        if (current_state != -1 && accepting[current_state]) {
            printf("ACEPTADA\n");
        } else {
            printf("RECHAZADA\n");
        }
        fflush(stdout);
    }
    
    return 0;
}

