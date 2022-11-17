with MicroBit.Radio;
with nrf.Radio;
use MicroBit;
with Ada.Real_Time; use Ada.Real_Time;
with CollectInput;
with MicroBit.Console; use MicroBit.Console;
with HAL; use HAL;

package body Brain is

   
  
   task body GetInputs is
      currentInputs : Payload_Data;
      button1HasTransitioned : Boolean := True;
      button2HasTransitioned : Boolean := True;
      button1State : Boolean := False;
      button2State : Boolean := False;
      period : Time_Span := Milliseconds(30);
      startTime : Time;
   begin
      startTime := Clock;
      loop
         delay until startTime;
         startTime := startTime + period;
         currentInputs := CollectInput.GetInputArray(0,1,2,3,4,6);
         Put_Line("button2 live: " & currentInputs(6)'Image);
         
         if currentInputs(5) = 0 and not button1HasTransitioned then
            button1HasTransitioned := True;
         elsif currentInputs(5) = 1 and button1HasTransitioned then
            button1State := not button1State;
            button1HasTransitioned := False;
         end if;
         if button1State then
            currentInputs(5) := 1;
         else
            currentInputs(5) := 0;
         end if;
         
         if currentInputs(6) = 0 and not button2HasTransitioned then
            button2HasTransitioned := True;
         elsif currentInputs(6) = 1 and button2HasTransitioned then
            button2State := not button2State;
            button2HasTransitioned := False;
         end if;
         if button2State then
            currentInputs(6) := 1;
         else
            currentInputs(6) := 0;
         end if;
         Put_Line("button2: " & currentInputs(6)'Image);
         
            InputPO.Set(currentInputs);
      end loop;
      
   end GetInputs;
   
   
   task body SendData is
      Txdata : Radio.RadioData;
      payloadData : Payload_Data;
      period : Time_Span := Milliseconds(60);
      startTime : Time;
   begin
      startTime := Clock;
      
      
      TxData.Length := 9;
      TxData.Version := 12;
      TxData.Group := 1;
      TxData.Protocol := 14;
      
      Radio.Setup(RadioFrequency => 2419,
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
