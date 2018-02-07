# SOS Detector Verilog
This is implementation of SOS Sequence detector using hardware description language Verilog. 

The SOS Detector Comprises of Three main Sub-system working together on same clock cycle. Each sub-system could be consider as module with sets of input and output.  
1- SOS Driver.   
2- Dash & Dot detector.  
3- Sequence identifier. 

### SOS diagram
![picture1](https://user-images.githubusercontent.com/36194509/35906992-87ac6f26-0c27-11e8-9c30-ba9f260c5d84.png)

### SOS block level diagram
![general](https://user-images.githubusercontent.com/36194509/35906997-8b7e633e-0c27-11e8-8682-84699ccdf0c7.png)

#### Driver Module timing diagram. 

![sos driver timing diagram](https://user-images.githubusercontent.com/36194509/35907008-95ad3fd8-0c27-11e8-8ca8-2c4b482ec8dd.png)

#### Dot-Dash Module timing diagram. 
![dot-dash module](https://user-images.githubusercontent.com/36194509/35907016-99d0eac4-0c27-11e8-9cce-ff4b10bbce9c.png)

#### Sequence-Identifier Module timing diagram. 
![sequence identifier](https://user-images.githubusercontent.com/36194509/35907022-9d86f636-0c27-11e8-9c36-70fb0b1e68f8.png)


