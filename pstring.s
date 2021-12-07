// 208250225 Lior Agron
.section .rodata
    .align 16
    CPY_ERR:     .string "invalid input!\n"
    END_OF_STR:  .string "\0"


.text
    .globl pstrlen
    .type pstrlen, @function
    #ARRAY IS IN %RDI
    pstrlen :
        xorq %rax, %rax      # result
        movzbq (%rdi), %rax     #moving first byte (which contains the len) into rax
        ret


    .globl replaceChar
    .type replaceChar, @function
    # taking 3 args. rdi: string A
    #                rsi: char to be replaced
    #                rdx: new char
    replaceChar :
        pushq %rbp
        movq  %rsp, %rbp
        pushq %r15      # i
        pushq %r14      # A[i]
        pushq %r13      # A
        movq  %rdi, %r13    #storing the start of the string
        movq  (%rsi), %rsi  #initializing the data within the address held in rsi
        xorq %r15, %r15
        movq (%rdx), %rdx
        call pstrlen
        jmp .REP_CON
        .REP :
                    # TODO: ASK SHOULD I ZERO RDI??
            movb %dl, (%rdi)
        .REP_CON :
            cmpq %r15, %rax
            je .REP_DONE #jump if # len < i
        inc %rdi
        leaq (%rdi),%r14
        inc %r15
        cmpb (%r14), %sil
        je .REP
        jmp .REP_CON
        .REP_DONE :
            movq %r13, %rax
            inc %rax
            popq %r13
            popq %r14
            popq %r15
            movq %rbp, %rsp
            popq %rbp
        ret

    .globl pstrijcpy
    .type pstrijcpy, @function
    pstrijcpy:
        pushq %rbp
        movq %rsp, %rbp
        pushq %r15
        pushq %r14
        pushq %r13

        movq %rdi, %r14
        movq %rsi, %r15
        movq %rdi, %r11

        call pstrlen
        cmpq %rax, %rcx
        jl .CPY_ERR

        movq %r14, %rdi
        call pstrlen
        cmpq %rax, %rcx
        jg .CPY_ERR

       movq (%rdx), %rdx
       movq (%rcx), %rcx
       inc  %r14
       inc  %r15
       addq %rdx, %r15
       addq %rdx, %r14

        .CPY_CON :
        cmp %rdx, %rcx
        jl .CPY_DONE

       # inc %r15


       xorq %r13, %r13
       movb (%r15), %r13b   # placing current char of str2 into r13
       #movb %r13b, (%r14, %rdx)
       movb %r13b, (%r14)   # placing said char in same index in str1
       addq $1, %r15
       addq $1, %r14
       inc %rdx
       jmp .CPY_CON


        .CPY_ERR :
            #PRINT ERR THEN JMP TO DONE
            movq $CPY_ERR, %rdi
            xorq %rax, %rax
            call printf
            jmp .CPY_DONE

        .CPY_DONE :
        inc  %r11
        movq %r11, %rax
        popq %r13
        popq %r14
        popq %r15
        movq %rbp, %rsp
        popq %rbp
        ret

    .globl swapCase
    .type swapCase, @function
    swapCase :
        pushq %rbp
        movq  %rsp, %rbp
        pushq %r15  #pstr
        movq %rdi, %r15

        .SWAP_CON :
        cmpq $0, (%rdi)
        je .SWAP_DONE

        cmpb $122, (%rdi)   # 122 is upper bound of lower case letters
        jg .NEXT

        cmpb $65, (%rdi)    # 65 is lower bound of upper case letters
        jl .NEXT

        cmpb $97, (%rdi)    #$97 is lower bound of lower case letters
        jg .TO_UPPER        #jumps if in range of lower case letters

        cmpb $90, (%rdi)    # 90 is upper bound of upper case letters
        jl .TO_LOWER        #jumps if in range of upper case letters

        jmp .NEXT           #if somehow anything else happened

        .TO_UPPER:
         subq $32, (%rdi)    #upper and lower case letters are set appart by 32 indices on the ASCII table.
         jmp .NEXT

        .TO_LOWER:
         add $32, (%rdi)

        .NEXT:
        incq %rdi           #move onto next char
        jmp .SWAP_CON

        .SWAP_DONE:
        movq %r15, %rax
        popq %r15
        movq %rbp, %rsp
        popq %rbp
        ret

    .globl pstrijcmp
    .type pstrijcmp, @function
    pstrijcmp :
        pushq %rbp
        movq %rsp, %rbp
        pushq %r15
        pushq %r14      # tmp char holder
        xorq %r15, %r15 # boolean. will be turned into 1 if loop is finished

        cmpb (%rdi), %cl    #if J is larger than the strings -> ERR
        jg .CMP_ERR

        cmpb (%rsi), %cl
        jg .CMP_ERR

        .CMP_CON :
        cmpq %rdx, %rcx
        je .CMP_DONE

        xorq %r14, %r14             #seperating the i-th char (i = rdx)
        movzbq (%rdi, %rdx), %r14
        cmpb %r14b, (%rsi, %rdx)
        jne .CMP_G_OR_L

        .CMP_G_OR_L :
        cmpb %r14b, (%rsi, %rdx)
        jg .CMP_GREATER
        jl .CMP_LESS

        incq %rdx
        jmp .CMP_CON

        .CMP_ERR :
        movq $CPY_ERR, %rdi
        xorq %rax, %rax
        call printf
        movq $-2, %rax
        jmp .CMP_DONE

        .CMP_GREATER :
        incq %r15
        jmp .CMP_DONE

        .CMP_LESS :
        decq %r15

        .CMP_DONE :
        xorq %rax, %rax
        movq %r15, %rax
        popq %r14
        popq %r15
        movq %rbp, %rsp
        popq %rbp
        ret
