# Naming convention to consider for different institutions

## generic

### ECMC internal variables

* Use camelCase for the naming of the internal variables.
This affects mostly the hardware defintion files in `$ROOT/hardware/*`
* Variables must start with the decripition followed by the index.
The description might also represents the data type, i.e. analog, binary, posAct, setPos, timestamp, ...
* Since many EtherCAT slaves have multiple input channels, _ALL_ channels will be given an index.
The index starts Fortran-style at `1`.
The index is of decimal type with two (2) zero padded digits to accommodate slaves with up to 99 inputs.
* In case the slave has a generic registers, those do _not_ feature an index.
See examples below for clarification.

#### List ecmc names
##### inputs
- binaryInput
- binaryInputArray
- diagnosticInput
- accelerometerStatus
- accelerometerActual
- accelerometerActualX
- accelerometerActualY
- accelerometerActualZ
- accelerometerSamples
- accelerometerTimestamp
- deviceStatus
- safeStatus
- voltageStatus
- timestampLatchPositive
- timestampLatchNegative
- id
- voltageActualUsIn
- voltageStatusUsIn
- voltageActualUpIn
- voltageStatusUpIn
- voltageActualUpOut
- voltageStatusUpOut
- encoderStatus
- binaryOutputStatus
- currentActual
- binaryOutputArrayReadBack
- analogInput
- analogInputSetpoint  (for analog drives, the analog setpoint value (reference) to the drive)
- analogInputActual    (for analog drives, the analog actual value (feedback) recived to the drive)
- temperatureActual
- voltageActual
- positionActualSecondary (for drives with multiple feedbacks)
- notConnected
- KL<slaveid>_binaryInput
- load
- ebus
- underVoltageEbus
- underVoltagePower
- powerOk
- overload
- currentActualResistor
- dutyCycle
- analogInputArray
- nextSyncTime
- sampleCount
- cycleCounter
- timestamp<id>_l32
- timestamp<id>_u32
- positionActualArray
- timerActual
- counterActual
- counterInputCycle
- operationHours
- controlValueDcMaster
- timePtp
- timeDc
- toggle
- encoderLatchPostion
- driveStatus
- posSatus                 (position interface)
- posPositionActual        (position interface)
- posVelocityActual        (position interface)
- posDriveTime             (position interface)

##### outputs
- binaryOutput
- binaryOutputArray
- deviceControl
- triState
- activate
- timestamp
- startTime
- pwmOutput       (pulse width modulation)
- driveControl
- encoderControl
- velocitySetpoint
- encoderValue
- mask
- binaryOutputArrayMask
- notConnected
- R,G,B (Red,Green,Blue)
- KL<slaveid>_binaryOutput
- analogOutputArray
- tc_cold
- timerStart
- timerReset
- counterIncrement
- counterReset
- buttonUp
- buttonDown
- buttonLeft
- buttonRight
- buttonEnter
- buttonToggle
- encoderControl           (position interface)
- driveControl             (position interface)
- posControl               (position interface)
- posPositionTarget        (position interface)
- posStartType             (position interface)
- posAccelerationSetpoint  (position interface)
- posDecelerationSetpoint  (position interface)

Note: Each slave will have a record set with status received by the master (ecmcEcSlave.template). These data are not registered as pdos in the hardware scripts. Therefore these alias and record names must not be used for pdo data:

#### Examples

* EL1008, 8 channel digital input

  * Channel 7

  | old         | new |
  |--           |--|
  |BI_7         |binaryInput07 |

  Assuming this is slave 103 on the first master it would translate into `ec0.s103.binaryInput07` internally for binary input 7.

* EL3164, 4 channel 16bit analog input (0--10V)

  * Channel 1

  | old         | new |
  |--           |--|
  |CH1_STATUS   |status01 |
  |CH1_VALUE    |analogInput01  |

  Assuming this is slave 42 on the first master it would translate into `ec0.s42.analogInput01` internally for the value channel.

* EP2308, 4 channel digital output, 0.5A + 4 channel digital input, 3 ms

  * Channel digital output 2

  | old         | new |
  |--           |--|
  |BO_3         |digitalOutput02 |

  * Channel digital input 3

  | old         | new |
  |--           |--|
  |BI_3         |digitalInput03 |

* EL5002, 2 channel SSI encoder interface

  * Channel 2

  | old         | new |
  |--           |--|
  |CH2_STATUS   |status02 |
  |CH2_VALUE    |positionActual02  |

  assuming this is slave 23 on the second master it would translate into `ec1.s23.positionActual02` internally for the status information.

* Keyence DL-EC1A, max 15 channel, EtherCAT Compatible Network Unit for High-Accuracy Digital Contact Sensors

  * generic

  | old         | new |
  |--           |--|
  |INP_REQ1     |requestInp |
  |DEV_STATUS   |status |
  |DEV_ERR_CODE |errCode  |

  * Channel 13

  | old         | new |
  |--           |--|
  |CH13_STATUS  |status13 |
  |CH13_VALUE   |analogInput13  |

  assuming this is slave 17 on the third master it would translate into `ec2.s17.errCode` internally for the error code information of the main unit.
  The actual data of the 13th input will reside under `ec2.s17.analogInput13`.

## PV Naming

The naming should follow the below concept:0

```
${ECMC_P}<type><id>-<name>
```

Or for terminals that have both channels and terminal specific data, the "Dev" type can be used.

```
${ECMC_P}Dev-<name>
```

Example: Status words
```
IOC_TEST:m0s000-Dev-Stat   # Status word for device
IOC_TEST:m0s000-CH1-Stat   # Status word for channel 1
IOC_TEST:m0s000-CH2-Stat   # Status word for channel 2
IOC_TEST:m0s000-EC-Stat    # Ethercat slave status word

```

### "type"

  | Type | Description    | Comment  |
  |--    |--              |--        |
  |BI    |Binary input    |          |
  |BO    |Binary output   |          |
  |AI    |Binary input    |          |
  |AO    |Analog output   |          |
  |CH    |Generic channel |          |
  |Drv   |Drive           |          |
  |Enc   |Encoder         |          |
  |Dev*  |Device*         | Shall only be used if the terminal have specifc data that cannot be assigned to a other type |
  |EC    |Ethercat        | Reserved for ethercat status data (from master, not process data) |
  |Cntr  |Counter         |          |
  |Tmr   |Timer           |          |
  |Pos   |Position        | Positioning interface of drives |
  |PLC   |ecmc PLCs       | |
  |DS    |Data storages   | |

### "id"

Id is the number of the "channel".

Example: Encoder with two channels
```
IOC_TEST:m0s000-Enc01-PosAct
IOC_TEST:m0s000-Enc02-PosAct
```

### "name"

The below abbrevations should be used for the "name" part of the PV:

  | Property (or part of) | Abbrevation for PV name (or part of) | Example PV |
  |--            |--      |--|
  |device        |dev     |  |
  |status        |stat    | DevStat |
  |control       |ctrl    |  |
  |command       |cmd     |  |
  |slave         |slave   |  |
  |latch         |latch   |  |
  |warning       |warn    |  |
  |error         |err     |  |
  |alarm         |alrm    |  |
  |acceleration  |acc     |  |
  |deceleration  |dec     |  |
  |accelerometer |acc     |  |
  |position      |pos     | LatchPos02 |
  |velocity,speed|velo    |  |
  |actual        |act     |  |
  |setpoint      |set     |  |
  |busy          |busy    |  |
  |done          |done    |  |
  |ready         |rdy     |  |
  |over          |ovr     |  |
  |range         |rng     |  |
  |run           |run     |  |
  |under         |undr    |  |
  |voltage       |volt    |  |
  |reset         |rst     |  |
  |auto          |auto    |  |
  |state         |state   |  |
  |triState      |tri     | TriState  |
  |start         |start   |  |
  |time          |time    | StartTime |
  |word          |wd      | CtrlWd    |
  |encoder       |enc     | EncCtrl   |
  |drive         |drv     | DrvCtrl   |
  |value         |val     | EncVal    |
  |short         |shrt    |  |
  |circuit       |circ    | ShrtCircAlrm |
  |rising        |rise    |  |
  |falling       |fall    |  |
  |mask          |mask    |  |
  |array         |array   |  |
  |current       |curr    |  |
  |red           |Red     |  |
  |green         |Green   |  |
  |blue          |Blue    |  |
  |disabled      |dis     |  |
  |input         |inp     |  |
  |output        |outp    |  |
  |load          |ld      |  |
  |enabled       |ena     |  |
  |short         |shrt    |  |
  |circuit       |circ    | shrtCirc |
  |overload      |ovrld   |  |
  |hardware      |hw      |  |
  |protection    |prot    | hwProt |
  |level         |lvl     |  |
  |cool          |cool    |  |
  |down          |dwn     |  |
  |lock          |lck     | coolDwnLck |
  |switch        |swtch   |  |
  |pdo           |pdo     |  |
  |diagnostics   |diag    |  |
  |channel       |ch      |  |
  |I2T           |i2t     |  |
  |duty          |dty     |  |
  |cycle         |cyc     | dtyCyc |
  |limit         |lim     |  |
  |next          |nxt     |  |
  |parity        |prty    |  |
  |frame         |frm     |  |
  |operation     |op      |  |
  |hours         |hrs     |  |

## ESS

## PSI

PSI naming convention for SLS-2.0 is not definitive yet (2020-11-16).
However, certain constrains can be derived from previous conventions and facilities in operation.
The PV names will comprise of a `PREFIX` terminated by a colon `:`, followed by device specific information.
A single colon (`:`) is allowed in the names.
The amount of special characters should be reduced to an absolute minimum.
At all cost the use of brackets and braces has to be avoided, even though EPICS allows such characters in PV names.
The PV names have to be descriptive and allow for changes in the system, w/o braking any dependicies.
It has to be kept in mind that potentially many clients connect to an IOC, w/o the initial integrator knowing thereof!
