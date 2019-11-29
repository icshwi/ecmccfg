############################################################
############# ESS Bilbao Mobile Tuner:

#Configure EK1100 etherCAT coupler
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=0, HW_DESC=EK1100"

#Configure EL1018 digital input terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=1, HW_DESC=EL1018"

#Configure EL2808 digital output terminal
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=2, HW_DESC=EL2808"

# Save the slave number for later
epicsEnvSet("ECMC_EC_SLAVE_NUM_DIG_OUT", "${ECMC_EC_SLAVE_NUM}")

#Configure EL5101 Incremental Encoder Interface
${SCRIPTEXEC} ${ecmccfg_DIR}addSlave.cmd, "SLAVE_ID=3, HW_DESC=EL5101"

#Configure EL7047 stepper drive terminal
${SCRIPTEXEC} ${ecmccfg_DIR}configureSlave.cmd, "SLAVE_ID=4, HW_DESC=EL7047, CONFIG=-Motor-Mclennan-HT18C230"

#- Max full step freq = 8000Hz (setting is 3)
ecmcConfigOrDie "Cfg.EcAddSdo(4,0x8012,0x5,3,1)"

#Apply hardware configuration
ecmcConfigOrDie "Cfg.EcApplyConfig(1)"
