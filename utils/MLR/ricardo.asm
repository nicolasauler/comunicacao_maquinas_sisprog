@ /0000
JP MAIN

; -- Subrotina de escrita
WRITE   K /0000 ; começo da subrotina
COMECO_LOOP_W GD /000
        PD /301 ; ARQUIVO DE ESCRITA
        JZ SAI_LOOP_W ; sai se for vazio (como no caso do timeout)
        MM TEXTO_ORIGINAL ; salva texto lido numa variavel
        ML K100 ; pega o char mais à esquerda
        DV K100
        SB TERMINADOR
        JZ SAI_LOOP_W ; sai se o char for um .
        LD TEXTO_ORIGINAL ; pegar o char mais à direita
        DV K100
        SB TERMINADOR
        JZ SAI_LOOP_W ; sai se o char for um .
        JP COMECO_LOOP_W

SAI_LOOP_W      LD TEMPO_SLEEP_W
        OS /71 ; aguarda alguns instantes
        RS WRITE ; retorna subrotina

; ---- Variáveis e constantes da subrotina
TEXTO_ORIGINAL K /0000          ; guarda temporariamente os 2 chars lidos
K100 K /0100            ; constante 0x0100
TERMINADOR K '.         ; char que marca a terminação do texto
TEMPO_SLEEP_W K =500        ; tempo de duracao de cada sleep
; ----
; --

; -- Subrotina de leitura
READ        K /0000 ; começo da subrotina
START_LOOP_R    LV /01
        JP SUP

CONTINUE_LOOP_R GD /300 ; ARQUIVO DE LEITURA
        JZ SAI_LOOP_R ; sai se não houverem mais dados para serem lidos
        PD /100
        JP START_LOOP_R

SAI_LOOP_R  LD TEMPO_SLEEP_R
        OS /71 ; aguarda alguns instantes
        RS READ ; retorna subrotina

; ---- Atualização do Arquivo
K /300 ; ARQUIVO DE LEITURA
SUP OS /10D ; atualiza o arquivo
JP CONTINUE_LOOP_R
; ----

; ---- Variáveis e constantes da subrotina
TEMPO_SLEEP_R K =5000
; ----
; --


; -- main
CABECALHO_WRITE K 'W:
CABECALHO_READ K 'R:
MAIN    LD CABECALHO_WRITE
        PD /100
        SC WRITE ; chama a rotina que escreve mensagens para a outra máquina
        LD CABECALHO_READ
        PD /100
        SC READ ; chama a rotina que lê as mensagens novas da outra máquina
        JP MAIN

FINAL   HM /00 ; na prática esse programa nunca encerra,
; mas poderiamos colocar um número máximo
; de iterações nesse loop
