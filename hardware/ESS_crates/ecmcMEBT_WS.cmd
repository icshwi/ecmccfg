############################################################
############# BI lab Wire Scanner EtherCAT HW configuration

#  ethercat slaves
#  0  0:0   PREOP  +  EK1100 EtherCAT Coupler (2A E-Bus)
#  1  0:1   PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
#  2  0:2   PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
#  3  0:3   PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
#  4  0:4   PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
#  5  0:5   PREOP  +  EL5101 1K. Inc. Encoder 5V
#  6  0:6   PREOP  +  EL5101 1K. Inc. Encoder 5V
#  7  0:7   PREOP  +  EL5101 1K. Inc. Encoder 5V
#  8  0:8   PREOP  +  EL9505 Netzteilklemme 5V
#  9  0:9   PREOP  +  EL1252-0050 2K. Fast Dig. Eingang 5V, 1µs, DC Latch
# 10  0:10  PREOP  +  EL1252-0050 2K. Fast Dig. Eingang 5V, 1µs, DC Latch
# 11  0:11  PREOP  +  EL9410 E-Bus Netzteilklemme (Diagnose)
# 12  0:12  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)
# 13  0:13  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)
# 14  0:14  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)

#Configure EK1100 coupler terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL1808"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL1808"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=3, HW_DESC=EL2819"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=4, HW_DESC=EL2819"

#Configure EL5101 incremental encoder terminal, motor 1
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=5, HW_DESC=EL5101"

#Configure EL5101 incremental encoder terminal, motor 2
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=6, HW_DESC=EL5101"

#Configure EL5101 incremental encoder terminal, motor 3
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=7, HW_DESC=EL5101"

# Configure EL9505 Power supply terminal 5V
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=8, HW_DESC=EL9505"

# Configure EL1252 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=9, HW_DESC=EL1252"

# Configure EL1252 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=10, HW_DESC=EL1252"

# Configure EL9410 Power supply with refresh of E-Bus.
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=11, HW_DESC=EL9410"

#Configure EL7041-0052 stepper drive terminal, motor 1
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=12, HW_DESC=EL7041-0052, CONFIG=-Motor-Nanotec-ST4118L1804-B"

#Configure EL7041-0052 stepper drive terminal, motor 2
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=13, HW_DESC=EL7041-0052, CONFIG=-Motor-Nanotec-ST4118L1804-B"

#Configure EL7041-0052 stepper drive terminal, motor 3
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=14, HW_DESC=EL7041-0052, CONFIG=-Motor-Nanotec-ST4118L1804-B"
# Configure hardware interlock on drive for motor 3
# Set function of input 1 to "Enable hardware"
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8012,0x32,1,1)"
# ECMC_EC_SLAVE_NUM is set by the last call to configureSlave.cmd, if this is moved from here (maybe to startup.script, but I don't know if this needs to go before ecmcConfigOrDie "Cfg.EcApplyConfig(1)", maybe this is the case)

#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
