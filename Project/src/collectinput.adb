package body CollectInput is
   
   
   function GetInputArray(analog1xPin : Pin_Id; analog1yPin : Pin_Id;
                          analog2xPin : Pin_Id; analog2yPin : Pin_Id;
                          button1Pin : Pin_Id; button2Pin : Pin_Id) return nRF.Radio.Payload_Data is
      arr : nRF.Radio.Payload_Data;
      analog1xVal : UInt8 := 127;
      analog1yVal : Uint8 := 127;
      analog1xRaw : Analog_Value;
      analog1yRaw : Analog_Value;
      analog2xVal : UInt8 := 127;
      analog2yVal : Uint8 := 127;
      analog2xRaw : Analog_Value;
      analog2yRaw : Analog_Value;
      button1Val : Uint8 := 0;
      button2Val : Uint8 := 0;
   begin
      analog1xRaw := Analog(analog1xPin);
      analog1yRaw := Analog(analog1yPin);
      analog2xRaw := Analog(analog2xPin);
      analog2yRaw := Analog(analog2yPin);
      
      analog1xVal := Uint8((255.0/1023.0)* Float(analog1xRaw));
      analog1yVal := Uint8((255.0/1023.0)* Float(analog1yRaw));
      analog2xVal := Uint8((255.0/1023.0)* Float(analog2xRaw));
      analog2yVal := Uint8((255.0/1023.0)* Float(analog2yRaw));
      
      if Set(button1Pin) then
         button1Val := 1;
      else
         button1Val := 0;
      end if;
      
      if Set(button2Pin) then
         button2Val := 1;
      else
         button2Val := 0;
      end if;
      
      
      arr(1) := analog1xVal;
      arr(2) := analog1yVal;
      arr(3) := analog2xVal;
      arr(4) := analog2yVal;
      arr(5) := button1Val;
      arr(6) := button2Val;
      
      return arr;
      
   end GetInputArray;
   
         

   

end CollectInput;
