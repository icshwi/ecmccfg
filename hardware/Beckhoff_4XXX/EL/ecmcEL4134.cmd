#-d /**
#-d   \brief hardware script for EL4134
#-d   \details 4 channel analog output module +-10V 16 bit
#-d   \author Anders Sandstroem
#-d   \file
#-d   \note SDOS
#-d   \param [out] SDO 0x1011:01 --> 1684107116 \b reset
#-d
#-d   \note TODO: Check if PDO index is correct (0x1100, it is 0x1600 in twincat)
#-d   \note TODO: Check if entry index is correct (0x1, it is 0x11 in twincat)
#-d
#-d */

epicsEnvSet("ECMC_EC_HWTYPE"             "EL4134")
epicsEnvSet("ECMC_EC_VENDOR_ID"          "0x2")
epicsEnvSet("ECMC_EC_PRODUCT_ID"         "0x10263052")

#- verify slave, including reset
ecmcFileExist(${ecmccfg_DIR}slaveVerify.cmd,1)
${SCRIPTEXEC} ${ecmccfg_DIR}slaveVerify.cmd "RESET=true"

ecmcFileExist(${ecmccfg_DIR}ecmcAnalogOutput_16bit.cmd,1)

#- ############ Config PDOS: Channel 1
${SCRIPTEXEC} ${ecmccfg_DIR}ecmcAnalogOutput_16bit.cmd "CH_ID=01,ECMC_PDO=0x1100,ECMC_ENTRY=0x7000,ECMC_ENTRY_OFFSET=0x1"

#- ############ Config PDOS: Channel 2
${SCRIPTEXEC} ${ecmccfg_DIR}ecmcAnalogOutput_16bit.cmd "CH_ID=02,ECMC_PDO=0x1100,ECMC_ENTRY=0x7010,ECMC_ENTRY_OFFSET=0x1"

#- ############ Config PDOS: Channel 3
${SCRIPTEXEC} ${ecmccfg_DIR}ecmcAnalogOutput_16bit.cmd "CH_ID=03,ECMC_PDO=0x1100,ECMC_ENTRY=0x7020,ECMC_ENTRY_OFFSET=0x1"

#- ############ Config PDOS: Channel 4
${SCRIPTEXEC} ${ecmccfg_DIR}ecmcAnalogOutput_16bit.cmd "CH_ID=04,ECMC_PDO=0x1100,ECMC_ENTRY=0x7030,ECMC_ENTRY_OFFSET=0x1"
