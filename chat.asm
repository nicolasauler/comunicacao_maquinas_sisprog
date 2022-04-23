; Only file
@   /0000
JP  MAIN

;; Constants
; WAIT ROUTINE
WAIT_TM K   =300  ; waits for 3 seconds  

; WRITE ROUTINE
EOL     K   /0010 ; line feed
CLR_BT  K   /0100 ; constant used to treat input to get specific bytes
INPUT   K   /0000 ; input variable to store data read

;; WAIT OS ROUTINE
WAIT    LD WAIT_TM  ; loads wait time to AC
        OS /71      ; call OS to wait for time in AC

;; WRITE TO FILE ROUTINE
; loops until a line feed is typed in stdin
; if either of the 2 bytes read at once is a \n char
; it gets out of read/write to file loop
; adapted from Aula 10 - 2022 Sistemas de Programacao
WRITE   GD /000     ; get from stdin
        PD /303     ; puts it in chat.dat
        MM INPUT    ; stores original data read
        ML CLR_BT   ; multiplies data by 100
        DV CLR_BT   ; then divides to obtain the second byte
        SB EOL      ; subtracts a \n char
        JZ WAIT     ; gets out of write loop
        LD INPUT    ; loads input so we can proceed to next byte
        DV CLR_BT   ; divides by 100 so we can get the first byte
        SB EOL      ; subtracts a \n char
        JZ WAIT     ; gets out of write loop
        JP WRITE    ; loops again to obtain next 2 bytes from stdin


# MAIN
