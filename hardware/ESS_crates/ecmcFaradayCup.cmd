############################################################
############# Faraday Cup EtherCAT HW configuration

#0  0:0  PREOP  +  EK1100 EtherCAT Coupler (2A E-Bus)
#1  0:1  PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
#2  0:2  PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
#3  0:3  PREOP  +  EL3214 4K. Ana. Eingang PT100 (RTD)
#4  0:4  PREOP  +  EL3174-0002 4K. Ana. Eingang  +/-10V, +/-20mA, 16 Bit, Galvanis
#5  0:5  PREOP  +  EL4134 4K. Ana. Ausgang -10/+10V. 16bit
#6  0:6  PREOP  +  EL9505 Netzteilklemme 5V
#7  0:7  PREOP  +  EL2124 4K. Dig. Ausgang 5V, 20mA
#8  0:8  PREOP  +  EK1110 EtherCAT-Verl�ngerung

#Configure EK1100 coupler terminal
#ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+$(ECMC_SLAVE_NUM_OFFSET)")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EK1100"

#Configure EL1808 digital input terminal
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+$(ECMC_SLAVE_NUM_OFFSET)")
epicsEnvShow("ECMC_SLAVE_NUM")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL1808"

#Configure EL2819 digital output terminal
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL2819"

# Configure EL3214 4K. Ana. Eingang PT100 (RTD)
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL3214"

#Configure EL3174 analog input configured to read 0 to 10V, NOTE: Use cutsom substitution file (ecmcEL7134_0to10V_FC.substitutions)! 
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL3174_0to10V,SUBST_FILE=ecmcEL3174_0to10V_FC.substitutions"

# Configure EL4134 analog output terminal 0-10V, NOTE: Use cutsom substitution file (ecmcEL4134_FC.substitutions)!
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL4134,SUBST_FILE=ecmcEL4134_FC.substitutions"

# Configure EL9505 power supply 5V
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL9505"

# Configure EL2124 digital output terminal 5V.
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EL2124"

#Configure EK1110 coupler terminal
ecmcEpicsEnvSetCalc("ECMC_SLAVE_NUM", "$(ECMC_SLAVE_NUM)+1")
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=$(ECMC_SLAVE_NUM), HW_DESC=EK1110"


#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
