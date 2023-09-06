       float FM_devided_FF = 0.0105;

            float function_F1 = F/4.0 - Mb1 / (4.0 * arm_length) - Mb2 / (4.0 * arm_length) +  Mb3 / (4.0 * FM_devided_FF);
            float function_F2 = F/4.0 + Mb1 / (4.0 * arm_length) + Mb2 / (4.0 * arm_length) +  Mb3 / (4.0 * FM_devided_FF);
            float function_F3 = F/4.0 + Mb1 / (4.0 * arm_length) - Mb2 / (4.0 * arm_length) -  Mb3 / (4.0 * FM_devided_FF);
            float function_F4 = F/4.0 - Mb1 / (4.0 * arm_length) + Mb2 / (4.0 * arm_length) -  Mb3 / (4.0 * FM_devided_FF);

            PWM1 = Inverse_thrust_function(function_F1);
            PWM2 = Inverse_thrust_function(function_F2);
            PWM3 = Inverse_thrust_function(function_F3);
            PWM4 = Inverse_thrust_function(function_F4);


int ModeStabilize::Inverse_thrust_function(float value){
    int PWM = 1100;
    
    float p1 = 0.0043;
    float p2 = -0.0533;
    float p3 = 0.2984;
    float p4 = 1.1487;
    
    PWM = p1 * value*value*value + p2*value*value + p3*value + p4;
    
    if (PWM > 1950){PWM = 1950;}
    if (PWM < 1100){PWM = 1100;}

    return PWM;
}
