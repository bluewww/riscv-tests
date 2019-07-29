// Test stepping over a variety of instructions.

        .global main
	.balign 256 // RI5CY's mtvec alignment constraint
        .align  2
trap_entry:
	nop                             // -0x10
	csrr a0, mepc                   // -0xe
	addi a0, a0, 4                  // -0xa
	csrw mepc, a0                   // -0x8
	mret                            // -0x4
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
        .word   0                       // 0x20 // illegal to trap_entry
	ecall                           // 0x24 // ecall to trap_entry
	ebreak                          // 0x24 // ebreak to trap_entry
        nop                             // 0x26

two:
        jr      t0                      // 0x28

