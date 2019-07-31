import targets
import testlib

class pulpissimo_hart(targets.Hart):
    xlen = 32
    misa = 0x40001104
    ram = 0x1c000000
    ram_size = 0x7fffc
    reset_vectors = [0x1c000080] # TODO: check this? what is our entry point
    # TODO: figure out why pulpissimo.cfg fails
    link_script_path = "pulpissimo_ri5cy.lds" 
    trigger_implemented = False

class pulpissimo(targets.Target):
    harts = [pulpissimo_hart()]
    openocd_config_path = "pulpissimo.cfg"
    timeout_sec = 1000
    supports_clint_mtime = False
