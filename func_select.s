// 208250225 Lior Agron
.section .rodata
    .align 16
    format_d:    .string "%d"    #int format
    print_d:     .string "%d\n"
    format_two_chars:    .string " %c %c"    #int format
        a:    .string "a"    #int format
            b:    .string "b"    #int format
    print_50:    .string "first pstring length: %d, second pstring length: %d\n"
    print_52:    .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
    print_53:    .string "length: %d, string: %s\n"
    CPY_ERR:     .string "invalid input!\n"
    OPT_ERR:     .string "invalid option!\n"
    .MANU:
        .quad .L0   #50
        .quad .L1   #51
        .quad .L2   #52
        .quad .L3   #53
        .quad .L4   #54
        .quad .L5   #55
        .quad .DEF  #default
    
.text
.globl run_func
.type run_func, @function
run_func:
    push %rbp
    movq %rsp, %rbp
    pushq %r14
    pushq %r15
    pushq %r11  #option
    leaq -50(%rdi), %r11
        #making space for two chars and four ints (16*6). this is the max amount of input we could recieve
    subq $96, %rsp
    andq $-16, %rsp
    movq %rsi, %r14      #first pstr
    movq %rdx, %r15      #second pstr

    cmpq $10, %r11
    je .L0
    cmpq $5, %r11        #if input is out of bounds, go to default
    ja .DEF
    cmpq $0, %r11
    jb .DEF
                            # if %rdi is x, go to the adress that is 8*x from the start of the manu
    jmp *.MANU(,%r11,8)
    
    .L0:
        movq $format_d, %rdi
        movq %r14, %rdi
        call pstrlen
        movq %rax, %r13     #len of first
        movq %r15, %rdi
        call pstrlen
        movq %rax, %r12     #len of second

        movq $print_50, %rdi
        movq %r13, %rsi
        movq %r12, %rdx
        xorq %rax, %rax
        call printf
        jmp .DONE
    .L1:

        jmp .DEF
    .L2:
        movq $format_two_chars, %rdi
        leaq -32(%rbp), %rsi    #oldchar
        leaq -33(%rbp), %rdx    #oldchar
        xorq %rax, %rax
        call scanf
/*
        movq $format_c, %rdi
        leaq -48(%rbp), %rsi    #newchar
        xorq %rax, %rax
        call scanf
*/
        movq %r14, %rdi         # 1st pstr
        leaq -32(%rbp), %rsi     # oldchar
        leaq -33(%rbp), %rdx    # newchar
        call replaceChar
        movq %rax, %rcx

        movq %r15, %rdi         # 2nd pstr
        leaq -32(%rbp), %rsi     # oldchar
        leaq -33(%rbp), %rdx    # newchar
        call replaceChar
        movq %rax, %r8

        movq $print_52, %rdi
        movq -32(%rbp), %rsi     # oldchar
        movq -33(%rbp), %rdx    # newchar

        xorq %rax, %rax
        call printf
        jmp .DONE
    .L3:
        movq $format_d, %rdi
        leaq -32(%rbp), %rsi    # i
        xorq %rax, %rax
        call scanf

        movq $format_d, %rdi
        leaq -48(%rbp), %rsi    # j
        xorq %rax, %rax
        call scanf

        movq %r14, %rdi
        movq %r15, %rsi
        leaq -32(%rbp), %rdx
        leaq -48(%rbp), %rcx
        call pstrijcpy
        movq %rax, %r13

        movq %r14, %rdi
        call pstrlen

        movq $print_53, %rdi
        movq %rax, %rsi
        movq %r13, %rdx
        xorq %rax, %rax
        call printf

        movq %r15, %rdi
        call pstrlen

        inc %r15
        movq $print_53, %rdi
        movq %rax, %rsi
        movq %r15, %rdx
        xorq %rax, %rax
        call printf
        jmp .DONE
    .L4:
        movq %r14, %rdi
        call swapCase
        movq $print_53, %rdi
        movzbq (%r14), %rsi
        leaq 1(%rax), %rdx
        xorq %rax, %rax
        call printf

        movq %r15, %rdi
        call swapCase
        movq $print_53, %rdi
        movzbq (%r15), %rsi
        leaq 1(%rax), %rdx
        xorq %rax, %rax
        call printf
        jmp .DONE

    .L5:
        movq $format_d, %rdi
        leaq -32(%rbp), %rsi    # i
        xorq %rax, %rax
        call scanf

        movq $format_d, %rdi
        leaq -48(%rbp), %rsi    # j
        xorq %rax, %rax
        call scanf

        movq %r14, %rdi
        movq %r15, %rsi
        movl -32(%rbp), %edx
        movl -48(%rbp), %ecx
        call pstrijcmp

        movq %rax, %rsi
        movq $print_d, %rdi
        xorq %rax, %rax
        call printf
        jmp .DONE

    .DEF:
        movq $OPT_ERR, %rdi
        xorq %rax, %rax
        call printf
    .DONE:
    popq %r11
    popq %r15
    popq %r14
    movq %rbp, %rsp
    popq %rbp
    ret
