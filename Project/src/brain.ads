with nRF.Radio; use nRF.Radio;

package Brain is

   task GetInputs with Priority => 1;
   task SendData with Priority => 2;
   
   protected InputPO is
      procedure Set(payload : Payload_Data);
      entry Get(payload : out Payload_Data);
   private
      payloadData : Payload_Data;
      isUpdated : Boolean := False;
   end InputPO;
   
   

end Brain;
