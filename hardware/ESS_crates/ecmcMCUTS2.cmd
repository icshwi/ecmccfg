############################################################
############# TS2:

#0  0:0  PREOP  +  EK1100 EtherCAT-Koppler (2A E-Bus)
#1  0:1  PREOP  +  EL1809 16K. Dig. Eingang 24V, 3ms
#2  0:2  PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
#3  0:3  PREOP  +  EL9410 E-Bus Netzteilklemme (Diagnose)
#4  0:4  PREOP  +  EL7047 1K. Schrittmotor-Endstufe (50V, 5A)
#5  0:5  PREOP  +  EL7047 1K. Schrittmotor-Endstufe (50V, 5A)
#6  0:6  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)
#7  0:7  PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
#8  0:8  PREOP  +  EL7041 1K. Schrittmotor-Endstufe (50V, 5A)
#9  0:9  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)


#Configure EL1100 EtherCAT Coupler
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL1809 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL1809"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL2819"

# Save the slave number for later
epicsEnvSet("ECMC_EC_SLAVE_NUM_DIG_OUT", "${ECMC_EC_SLAVE_NUM}")

# Configure EL9410 Power supply with refresh of E-Bus.
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=3, HW_DESC=EL9410"

#Configure EL7047 stepper drive terminal, motor 1 for power divider
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=4, HW_DESC=EL7047, CONFIG=-Motor-AMS-AM23-239-3"

#Configure EL7047 stepper drive terminal, motor 2 for power divider
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=5, HW_DESC=EL7047, CONFIG=-Motor-AMS-AM23-239-3"

#Configure EL7041-0052 stepper drive terminal, motor 1 for cavity tuner
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=6, HW_DESC=EL7041-0052, CONFIG=-Motor-VSS-52.200.2.5"

#Configure EL7041 stepper drive terminal, motor 2 for cavity tuner
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=7, HW_DESC=EL7041, CONFIG=-Motor-VSS-52.200.2.5"

#Configure EL7041 stepper drive terminal, motor 3 for cavity tuner
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=8, HW_DESC=EL7041, CONFIG=-Motor-VSS-52.200.2.5"

#Configure EL7041-0052 stepper drive terminal, motor 4 for cavity tuner
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=9, HW_DESC=EL7041-0052, CONFIG=-Motor-VSS-52.200.2.5"


#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
