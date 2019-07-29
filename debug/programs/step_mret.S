// Test stepping over a variety of instructions, uses mret.

        .global main
	.balign 256 // RI5CY's mtvec alignment constraint
        .align  2
trap_entry:
	nop                             // -8
	mret                            // -4
main:
        la      t0, trap_entry          // 0, 4
        csrw    mtvec, t0               // 0x8

        li      t0, 5                   // 0xc
        beq     zero, zero, one         // 0x10
        nop                             // 0x14
one:
        beq     zero, t0, one           // 0x18
        // Use t0 instead of ra to force a 32-bit opcode in C mode. Otherwise
        // 32-bit and 64-bit binaries end up with different instructions (I
        // didn't pursue this).
        jal     t0, two                 // 0x1c

three:
        .word   0                       // 0x20
        nop                             // 0x24

two:
        jr      t0                      // 0x28

