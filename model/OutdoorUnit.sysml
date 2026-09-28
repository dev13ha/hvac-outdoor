// @hvac/outdoor is the whole outdoor unit. Geometry: Unit 24K.STEP.
// Depends on the fan motor and the compressor.
// The fan is not imported here; OutdoorFanMotor already owns OutdoorAxialFan.
import ScalarValues::*;
import OutdoorFanMotor::*;
import OutdoorCompressor::*;

package OutdoorUnit {

port def AmbientAirPort;
port def RefrigerantPort;
port def AcPowerPort;

part def AluminumCondenserFins;
part def CopperCondenserTubes;
part def GalvanizedSteelCabinet;

part def CondenserCoil {
    port refrigerantIn : RefrigerantPort;
    port refrigerantOut : RefrigerantPort;
    port airIn : AmbientAirPort;
    port airOut : AmbientAirPort;
    attribute faceAreaM2 : Real = 0.42;
    attribute finDensityFpi : Real = 18;
    attribute rows : Real = 2;
    part fins : AluminumCondenserFins;
    part tubes : CopperCondenserTubes;
}

part def OutdoorUnit {
    port mains : AcPowerPort;
    port ambientIn : AmbientAirPort;
    port ambientOut : AmbientAirPort;
    port liquidOut : RefrigerantPort;
    port suctionIn : RefrigerantPort;
    attribute nominalCapacityBtuH : Real = 24000;
    attribute nominalCoolingW : Real = 7034;
    part cabinet : GalvanizedSteelCabinet;
    part fanMotor : MatchedFanMotor;
    part compressor : RotaryCompressor;
    part condenser : CondenserCoil;
    connect ambientIn to fanMotor.airIn;
    connect fanMotor.airOut to condenser.airIn;
    connect condenser.airOut to ambientOut;
    connect compressor.discharge to condenser.refrigerantIn;
    connect condenser.refrigerantOut to liquidOut;
    connect suctionIn to compressor.suction;
    connect mains to fanMotor.power;
    connect mains to compressor.power;
}

}
