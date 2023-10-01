# apb
AMBA APB protocol specification document is attached. IHI0024E_amba_apb_architecture_spec.pdf
The UVC shall be able to act as Master and Slave roles, and for sure – as Active/Passive
UVC building steps:
1. UVC Package - generate sv package , including uvm libs import and all files below:
2. Interface - Follow the spec to understand what signals you should have in the apb_if.sv
a. Add different modports for master driver, slave driver and monitor.
3. Packet item – extend uvm_sequence_item with relevant fields required for APB transaction, which fields you need for transaction?
- Only data, addr , command fields which are changed per transaction.
- Controls: psel , penable and pready are controls that will be always driven from driver following the protocol
4. Basic Sequence – extend uvm_sequence , add the ability to inject single and more apb items , use random and constraints for setting repeat number and item content
5. APB Agent – generate all classes that should be included in agent.
a. Regarding driver , you should code 2 separate driver per master/slave
The difference will be in the drive_to_dut function
TB and Simple Test
For testing your agent we will instantiate only master interface in the tb module . set it to the uvc agent as required.
In this stage we only want to be able to follow interface signals waves , and check our built drivers , but , we need a slave that drive ro us the pready and prdata signals
For that – we need 1 master agent – the master to send the command – and the DUT APB slave will re-act.
