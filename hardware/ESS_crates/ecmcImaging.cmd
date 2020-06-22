############################################################
############# BI lab Imaging System EtherCAT HW configuration

#$ ethercat slaves
#0  0:0  PREOP  +  EK1100 EtherCAT Coupler (2A E-Bus)
#1  0:1  PREOP  +  EL1808 8K. Dig. Eingang 24V, 3ms
#2  0:2  PREOP  +  EL2819 16K. Dig. Ausgang 24V, 0,5A, Diagnose
#3  0:3  PREOP  +  EL7041-0052 1Ch. Stepper motor output stage (50V, 5A)

#Configure EK1100 coupler terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL1808 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL1808"

#Configure EL2819 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL2819"

#Configure EL7041-0052 stepper drive terminal, motor 1
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=3, HW_DESC=EL7041, CONFIG=-Motor-grey"

#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
