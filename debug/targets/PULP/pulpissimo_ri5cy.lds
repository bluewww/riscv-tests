OUTPUT_ARCH( "riscv" )

MEMORY
{
	mem (RWX)         : ORIGIN = 0x1c000000, LENGTH = 0x000fc000
}

SECTIONS
{
  .text :
  {
    *(.text.entry)
    *(.text)
  } >mem

  /* data segment */
  .data : { *(.data) } >mem

  .sdata : {
    __global_pointer$ = . + 0x800;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2)
    *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  } >mem

  /* bss segment */
  __bss_start = .;
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } >mem
  .bss : { *(.bss) }
  __bss_end = .;

  __malloc_start = .;
  . = . + 512;

  /* End of uninitalized data segement */
  _end = .;
}

ENTRY(_start)
