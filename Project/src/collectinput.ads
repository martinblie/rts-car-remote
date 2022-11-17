with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with HAL; use HAL;
with nRF.Radio;
package CollectInput is
   
  
   

   function GetInputArray(analog1xPin : Pin_Id; analog1yPin : Pin_Id;
                          analog2xPin : Pin_Id; analog2yPin : Pin_Id;
                         button1Pin : Pin_Id; button2Pin : Pin_Id) return nRF.Radio.Payload_Data;
     

   

end CollectInput;
