############################################################
############# Parmetrization of EL7041 for motor Phytron VSS 57.200.2.5 (for grey)

# can get sdos from "ethercat sdos -p 3", where 3 is the module position

# My motor is model VSS 57.200.2.5 by Phytron (bioplar windings) coupled to a 
# 0.1 inch pitch leadscrew in my setup through Phytron's VPGL 52/16 gearbox
# for a 16:1 reduction ratio
# This motor's datasheet says it takes 2.5A/phase, 70V max, 0.8 ohm/phase
# and 2.9mH/phase

# if the motor can spin with a max rotational velocity of 600 RPM
# (that's a 128,000 Hz step frequency in 1/64 step mode):
# the leadscrew turns at 600/16 = 37.5 RPM
# and the carriage moves at 2.54 * 37.5 = 95.25 mm/minute
# so then we should expect the assembly to take
# 230/95.25 = 2 min ~24.8 seconds to move by one screen position (230mm)

#Set max current (unit 1 mA)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x1,2500,2)"

#Reduced current (units 1 mA)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x2,500,2)"

#Nominal voltage (unit 1 mV)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x3,48000,2)"

#Coil resistance (unit 10mOhm)
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x4,80,2)"

#Motor steps per revoution
ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0x6,200,2)"
 
#Coil inductance (unit 0.01mH)
#ecmcConfigOrDie "Cfg.EcAddSdo(${ECMC_EC_SLAVE_NUM},0x8010,0xA,290,2)"
