############################################################
############# icBLM HVPS ISEG EtherCAT HW


#0  0:0  PREOP  +  EK1100 EtherCAT-Koppler (2A E-Bus)
#1  0:1  PREOP  +  EL3174-0002 4K. Ana. Eingang  +/-10V, +/-20mA, 16 Bit, Galvanis
#2  0:2  PREOP  +  EL4134 4K. Ana. Ausgang -10/+10V. 16bit
#3  0:3  PREOP  +  EL9505 Netzteilklemme 5V
#4  0:4  PREOP  +  EL1252-0050 2K. Fast Dig. Eingang 5V, 1ï¿½s, DC Latch
#5  0:5  PREOP  +  EL2124 4K. Dig. Ausgang 5V, 20mA

#Configure EK1100 coupler terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL3174 analog input configured to read 0 to 10V, NOTE: Use cutsom substitution file (ecmcEL7134_0to10V_FC.substitutions)! 
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL3174_0to10V"

# Configure EL4134 analog output terminal 0-10V, NOTE: Use cutsom substitution file (ecmcEL4134_FC.substitutions)!
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL4134"

# Configure EL9505 power supply 5V
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=3, HW_DESC=EL9505"

# Configure EL1252 digital input terminal 5V.
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=4, HW_DESC=EL1252"

# Configure EL2124 digital output terminal 5V.
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=5, HW_DESC=EL2124"

#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
