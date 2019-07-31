import targets
import testlib

class pulpissimo_ri5cy_hart(targets.Hart):
    xlen = 32
    misa = 0x40001104
    ram = 0x1c000000
    ram_size = 0xfc000
    reset_vectors = [0x1c000080]
    link_script_path = "pulpissimo_ri5cy.lds"
    trigger_implemented = False

class pulpissimo_ri5cy(targets.Target):
    harts = [pulpissimo_ri5cy_hart()]
    openocd_config_path = "pulpissimo_ri5cy.cfg"
    timeout_sec = 1000
    supports_clint_mtime = False

    # timeout_sec = 30
    # def create(self):
    #     return testlib.VsimSim(sim_cmd=self.sim_cmd, debug=False)
#/gdbserver.py --print-log-names --sim_cmd "make -C ../.. vcs-run" --server_cmd "openocd -d" targets/PULP/pulpissimo_ri5cy.py StepTest
# ./gdbserver.py --print-log-names --sim_cmd "make -C ../.. vsim-run VSIM_FLAGS+=+wlfdump" --server_cmd "openocd -d" targets/PULP/pulpissimo_ri5cy.py StepTest
# ./gdbserver.py --print-log-names --sim_cmd "make -C ../.. vsim-run VSIM_FLAGS+=+wlfdump" --server_cmd "openocd -d" targets/PULP/pulpissimo_ri5cy.py DebugBreakpoint DebugChangeString DebugCompareSections DebugExit DebugFunctionCall DebugSymbols DebugTurbostep InstantChangePc InstantHaltTest InterruptTest
    print_log_names = True
    def create(self):
        return testlib.VsimSim(sim_cmd=self.sim_cmd,
                               debug=False, timeout=600)
