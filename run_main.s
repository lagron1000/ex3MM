// 208250225 Lior Agron
#read only data. declaring constant formats.
.section .rodata
    .align 16
    format_d:    .string "%d"    #int format
    format_s:    .string "%s"    #string format
    size_s:      .long   256     #max size of string
    size_d:      .long   16      #size for int
    

.text
/*
.globl main
.type main, @function
main:
    movq %rsp, %rbp #for correct debugging
    call run@PLT
    ret
   */
        ################################## TODO: CHANGE TO RUN_MAIN BEFORE SUBMITING
.globl run
.type run, @function
run:                        #running main function. makes two pstrings using user input and uses them as per usesrs wish
    pushq %rbp
    movq %rsp,%rbp
    pushq %r14
    pushq %r15
    #making space for two ints
    subq $16, %rsp
    subq $16, %rsp

    #making space for two strings
    subq $256, %rsp
    subq $256, %rsp

    subq $16, %rsp

    movq $format_d, %rdi
    leaq -272(%rbp), %rsi       # 1st pstr len
    xorq %rax, %rax
    call scanf

    movq $format_s, %rdi
    leaq -271(%rbp), %rsi       # 1st str
    xorq %rax, %rax
    call scanf

    movq $format_d, %rdi
    leaq -544(%rbp), %rsi       # 2nd pstr len
    xorq %rax, %rax
    call scanf


    movq $format_s, %rdi
    leaq -543(%rbp), %rsi       # 2nd str
    xorq %rax, %rax
    call scanf

    movq $format_d, %rdi
    leaq -560(%rbp), %rsi       # option
    xorq %rax, %rax
    call scanf


    leaq -272(%rbp), %rsi
    leaq -544(%rbp), %rdx
    leaq -560(%rbp), %rdi
    movzbq (%rdi), %rdi
    call run_func


    movq %rbp, %rsp
    popq %rbp
    ret
    
    

    