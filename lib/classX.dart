class X {
  final String Time;
  final String Speed;
  final String Battery;
  final String BatteryTotalCurrent;
  final String BatteryAvgVoltage;
  final String Battery_1_Current;
  final String Battery_2_Current;
  final String Battery_3_Current;
  final String Battery_1_SOC;
  final String Battery_2_SOC;
  final String Battery_3_SOC;
  final String Battery_1_VOLT;
  final String Battery_2_VOLT;
  final String Battery_3_VOLT;
  final String Throttle_percentage;
  final String Controller_Temp;
  final String Motor_temp;
  final String Motor_DC_Current;
  final String Motor_DC_Voltage;
  final String Motor_AC_Voltage;
  final String Motor_AC_Current;
  final String TRIP_1;
  final String T_sense1;
  final String T_sense2;
  final String T_sense3;
  final String T_sense4;

  X(
      this.Time,
      this.Speed,
      this.Battery,
      this.BatteryTotalCurrent,
      this.BatteryAvgVoltage,
      this.Battery_1_Current,
      this.Battery_2_Current,
      this.Battery_3_Current,
      this.Battery_1_SOC,
      this.Battery_2_SOC,
      this.Battery_3_SOC,
      this.Battery_1_VOLT,
      this.Battery_2_VOLT,
      this.Battery_3_VOLT,
      this.Throttle_percentage,
      this.Controller_Temp,
      this.Motor_temp,
      this.Motor_DC_Current,
      this.Motor_DC_Voltage,
      this.Motor_AC_Voltage,
      this.Motor_AC_Current,
      this.TRIP_1,
      this.T_sense1,
      this.T_sense2,
      this.T_sense3,
      this.T_sense4);

  X.fromJson(Map<String, dynamic> json)
      : Time = json['Time'],
        Speed = json['Speed'],
        Battery = json['Battery'],
        BatteryTotalCurrent = json['BatteryTotalCurrent'],
        BatteryAvgVoltage = json['BatteryAvgVoltage'],
        Battery_1_Current = json['Battery_1_Current'],
        Battery_2_Current = json['Battery_2_Current'],
        Battery_3_Current = json['Battery_3_Current'],
        Battery_1_SOC = json['Battery_1_SOC'],
        Battery_2_SOC = json['Battery_2_SOC'],
        Battery_3_SOC = json['Battery_3_SOC'],
        Battery_1_VOLT = json['Battery_1_VOLT'],
        Battery_2_VOLT = json['Battery_2_VOLT'],
        Battery_3_VOLT = json['Battery_3_VOLT'],
        Throttle_percentage = json['Throttle_percentage'],
        Controller_Temp = json['Controller_Temp'],
        Motor_temp = json['Motor_temp'],
        Motor_DC_Current = json['Motor_DC_Current'],
        Motor_DC_Voltage = json['Motor_DC_Voltage'],
        Motor_AC_Voltage = json['Motor_AC_Voltage'],
        Motor_AC_Current = json['Motor_AC_Current'],
        TRIP_1 = json['TRIP_1'],
        T_sense1 = json['T_sense1'],
        T_sense2 = json['T_sense2'],
        T_sense3 = json['T_sense3'],
        T_sense4 = json['T_sense4'];

  Map<String, dynamic> toJson() => {
        'Time': Time,
        'Speed': Speed,
        'Battery': Battery,
        'BatteryTotalCurrent': BatteryTotalCurrent,
        'BatteryAvgVoltage': BatteryAvgVoltage,
        'Battery_1_Current':Battery_1_Current,
        'Battery_2_Current':Battery_2_Current,
        'Battery_3_Current':Battery_3_Current,
        'Battery_1_SOC':Battery_1_SOC,
        'Battery_2_SOC':Battery_2_SOC,
        'Battery_3_SOC':Battery_3_SOC,
        'Battery_1_VOLT':Battery_1_VOLT,
        'Battery_2_VOLT':Battery_2_VOLT,
        'Battery_3_VOLT':Battery_3_VOLT,
        'Throttle_percentage':Throttle_percentage,
        'Controller_Temp':Controller_Temp,
        'Motor_temp':Motor_temp,
        'Motor_DC_Current':Motor_DC_Current,
        'Motor_DC_Voltage':Motor_DC_Voltage,
        'Motor_AC_Voltage':Motor_AC_Voltage,
        'Motor_AC_Current':Motor_AC_Current,
        'TRIP_1':TRIP_1,
        'T_sense1':T_sense1,
        'T_sense2':T_sense2,
        'T_sense3':T_sense3,
        'T_sense4':T_sense4
      };
}
