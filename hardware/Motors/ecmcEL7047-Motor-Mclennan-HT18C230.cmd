#-d /**
#-d   \brief hardware script for EL7047-Motor-Mclennan HT18C230
#-d   \details Parmetrization of EL7047 for motor Mclennan HT18C230
#-d   \author Julen Etxeberria
#-d   \file
#-d   \note Phase Current: 1.73 A
#-d   \note Resistence: 1.5 Ohm
#-d   \note Inductance: 4.8 mH
#-d   \note Beckhoff Manual for EL7047: https://download.beckhoff.com/download/document/io/ethercat-terminals/el70x7en.pdf
#-d */

#- Set max current (unit 1mA)
#- ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,2115,2)"
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,1730,2)"

#- Reduced current 500mA (unit 1mA)
#- ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,500,2)"
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,2000,2)"

#- Nominal voltage 48V (unit 10mV)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x3,4800,2)"

#- Coil resistance 1.5 Ohm (unit 10mOhm)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x4,150,2)"

#- Motor full steps count 200 - step angle degree: 1.8 deg
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x6,200,2)"

#- Coil inductance 4.8mH (unit 0.01mH)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0xA,480,2)"
