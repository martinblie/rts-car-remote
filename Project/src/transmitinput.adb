with MicroBit.Radio;
use MicroBit;
  

package body TransmitInput(payload : nrf.Radio.Payload_Data) is
   
   procedure SendInputs is
      TxData : Radio.RadioData;
   begin
      TxData.Length := 6;
      TxData.Version := 12;
      TxData.Group := 1;
      TxData.Protocol := 14;
      
      Radio.Setup(RadioFrequency => 2407,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);
      
      TxData.Payload := payload;
      Radio.Transmit
                  
        

   

end TransmitInput;
