require ecmccfg,dev

##############################################################################
## Initiation:
epicsEnvSet("IOC"          ,"LEBT-010:ID-Iris")
epicsEnvSet("ECMCCFG_INIT" ,"")  #Only run startup once (auto at PSI, need call at ESS), variable set to "#" in startup.cmd
epicsEnvSet("SCRIPTEXEC"   ,"$(SCRIPTEXEC="iocshLoad")")

# run module startup.cmd (only needed at ESS  PSI auto call at require)
$(ECMCCFG_INIT)$(SCRIPTEXEC) ${ecmccfg_DIR}startup.cmd, "IOC=$(IOC),ECMC_VER=6.0.1, EthercatMC_VER=3.0.2, stream_VER=2.8.10"

##############################################################################
## Configure hardware:

# 0   0:0   PREOP  +  EK1100 EtherCAT Coupler (2A E-Bus)
# 1   0:1   PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
# 2   0:2   PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
# 3   0:3   PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
# 4   0:4   PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
# 5   0:5   PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
# 6   0:6   PREOP  +  EL9410 E-Bus Netzteilklemme (Diagnose)
# 7   0:7   PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
# 8   0:8   PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
# 9   0:9   PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
# 10  0:10  PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
# 11  0:11  PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
# 12  0:12  PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)


#Configure EK1100 EtherCAT coupler
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL1808"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL1808"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=3, HW_DESC=EL1808"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=4, HW_DESC=EL2819"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=5, HW_DESC=EL2819"

#Configure EL9410 Power supply with refresh of E-Bus.
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=6, HW_DESC=EL9410"

#Configure EL7041 stepper drive terminal, motor 1
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=7, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

#Configure EL7041 stepper drive terminal, motor 2
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=8, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

#Configure EL7041 stepper drive terminal, motor 3
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=9, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

#Configure EL7041 stepper drive terminal, motor 4
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=10, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

#Configure EL7041 stepper drive terminal, motor 5
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=11, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

#Configure EL7041 stepper drive terminal, motor 6
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=12, HW_DESC=EL7041, CONFIG=-Motor-Owis-LTM60"

# Apply hardware configuration
${SCRIPTEXEC} ${ecmccfg_DIR}applyConfig.cmd


##############################################################################
############# Write outputs in order to power switches (see elec. drawings):

ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_1,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_2,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_3,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_4,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_5,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_6,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_7,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_8,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_9,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_10,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_11,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_12,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_13,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_14,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_15,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(4,BO_16,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_1,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_2,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_3,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_4,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_5,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_6,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_7,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_8,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_9,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_10,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_11,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_12,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_13,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_14,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_15,1)"
ecmcConfigOrDie "Cfg.WriteEcEntryIDString(5,BO_16,1)"

##############################################################################
############# Physical axis configuration

${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_1.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_1.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_2.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_2.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_3.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_3.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_4.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_4.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_5.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_5.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureAxis.cmd,            "CONFIG=./cfg/mtr_6.pax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/mtr_6.sax"

##############################################################################
############# Virtual Axsi configuration

#
${SCRIPTEXEC} ${ecmccfg_DIR}configureVirtualAxis.cmd,            "CONFIG=./cfg/slit_center.vax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/slit_center.sax"
#
${SCRIPTEXEC} ${ecmccfg_DIR}configureVirtualAxis.cmd,            "CONFIG=./cfg/slit_gap.vax"
${SCRIPTEXEC} ${ecmccfg_DIR}applyAxisSynchronization.cmd, "CONFIG=./cfg/slit_gap.sax"

##############################################################################
############# Configure diagnostics:

ecmcConfigOrDie "Cfg.EcSetDiagnostics(1)"
ecmcConfigOrDie "Cfg.EcEnablePrintouts(0)"
ecmcConfigOrDie "Cfg.EcSetDomainFailedCyclesLimit(100)"
ecmcConfigOrDie "Cfg.SetDiagAxisIndex(1)"
ecmcConfigOrDie "Cfg.SetDiagAxisFreq(2)"
ecmcConfigOrDie "Cfg.SetDiagAxisEnable(0)"

# go active
${SCRIPTEXEC} ${ecmccfg_DIR}setAppMode.cmd

