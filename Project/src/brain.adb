with MicroBit.Radio;
with nrf.Radio;
use MicroBit;
with Ada.Real_Time; use Ada.Real_Time;
with CollectInput;
with MicroBit.Console;
with HAL; use HAL;

package body Brain is

   
  
   task body GetInputs is
      previousInputs : Payload_Data;
      currentInputs : Payload_Data;
      period : Time_Span := Milliseconds(40);
      startTime : Time;
   begin
      startTime := Clock;
      loop
         delay until startTime;
         startTime := startTime + period;
         currentInputs := CollectInput.GetInputArray(0,1,2,3);
         MicroBit.Console.Put_Line(" analogx: " & UInt8'Image(currentInputs(1)));
         if currentInputs /= previousInputs then
            InputPO.Set(currentInputs);
            previousInputs := currentInputs;
         end if;
      end loop;
      
   end GetInputs;
   
   
   task body SendData is
      Txdata : Radio.RadioData;
      payloadData : Payload_Data;
      period : Time_Span := Milliseconds(50);
      startTime : Time;
   begin
      startTime := Clock;
      
      
      TxData.Length := 8;
      TxData.Version := 12;
      TxData.Group := 1;
      TxData.Protocol := 14;
      
      Radio.Setup(RadioFrequency => 2407,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);
      loop
         delay until startTime;
         startTime := startTime + period;
         InputPO.Get(payloadData);
         Txdata.Payload := payloadData;
         Radio.Transmit(Txdata);
      end loop;
   end SendData;
   
      
      
   
   
   protected body InputPO is
      procedure Set(payload : Payload_Data) is
      begin
         payloadData := payload;
         isUpdated := True;
      end Set;
      
      entry Get(payload : out Payload_Data)
        when isUpdated is
      begin
         payload := payloadData;
         isUpdated := False;
      end Get;
   end InputPO;
      

end Brain;
