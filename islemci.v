`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2021 15:31:50
// Design Name: 
// Module Name: islemci
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


 module islemci(
    input saat,
    input reset,    
    input  [31:0] buyruk,
    output  reg [31:0] ps,
    output  reg [31:0] yazmac_on
    );
    reg [31:0] register[15:0];    
     reg [31:0]ps_Tutucu;
    always@* begin            
        ps = ps_Tutucu;
        yazmac_on=register[10];
    end
    
    always@(posedge saat) begin
    if(reset==0)begin
       ps=0;
    end  
    else begin
    ////////////////////////////////////////////////////////////////
        if(buyruk[6:0]==51)begin
            if(buyruk[14:12]==0)begin
               if(buyruk[30]==0)begin//add                   
                 register[buyruk[11:5]]=register[buyruk[19:15]]+register[buyruk[24:20]];
                 ps_Tutucu=ps+4;   
                end 
                else begin//sub
                    register[buyruk[11:5]]=register[buyruk[24:20]]-register[buyruk[19:15]]; 
                    ps_Tutucu=ps+4;
                end
            end
            else if(buyruk[14:12]==4)begin//xor
                register[buyruk[11:5]]=register[buyruk[24:20]]^register[buyruk[19:15]];
                 ps_Tutucu=ps+4;
            end
            else if(buyruk[14:12]==7)begin//and
              register[buyruk[11:5]]=register[buyruk[24:20]]&register[buyruk[19:15]];
              ps_Tutucu=ps+4;
            end
            if(buyruk[14:12]==5)begin
               if(buyruk[30]==0)begin//srl
                    
                end 
                else begin//sra
                     
                end
            end
            
        end        
        /////////////////////////////////////////////////////
        else if(buyruk[6:0]==19)begin
            if(buyruk[14:12]==0)begin//addi
                if(buyruk[31]==0)begin
                    register[buyruk[11:5]]=register[buyruk[19:15]]+buyruk[31:20];
                    ps_Tutucu=ps+4;
                end
                 if(buyruk[31]==0)begin
                    register[buyruk[11:5]]=register[buyruk[19:15]]+buyruk[31:20];
                   ps_Tutucu=ps+4;
                end
            end
            else if(buyruk[14:12]==1)begin//subi
                register[buyruk[11:5]]=register[buyruk[19:15]]-buyruk[31:20];
               ps_Tutucu=ps+4; 
            end
            else if(buyruk[14:12]==4)begin//xori
                register[buyruk[11:5]]=register[buyruk[24:20]]^buyruk[31:20];
                ps_Tutucu=ps+4;
            end
            else if(buyruk[14:12]==2)begin//srti
            end
            else if(buyruk[14:12]==5)begin//srai
            end      
        end
        /////////////////////////////////////////////////////
        else if(buyruk[6:0]==103)begin//jalr
            register[buyruk[11:5]]=ps_Tutucu;
           ps_Tutucu=register[buyruk[19:15]]+4;
        end
        /////////////////////////////////////////////////////
        else if(buyruk[6:0]==99)begin   
            if(buyruk[14:12]==0)begin//beq
                if(register[buyruk[19:15]]==register[buyruk[24:20]])begin                     
                    ps_Tutucu=buyruk[31:20];
                end 
                else begin 
                    ps_Tutucu=ps+4;
                 end                
            end           
            else if(buyruk[14:12]==4)begin//bqe
                 if(register[buyruk[19:15]]>=register[buyruk[24:20]])begin
                   ps_Tutucu=buyruk[31:20];
                 end 
                 else begin 
                     ps_Tutucu=ps+4;
                 end               
            end            
            else if(buyruk[14:12]==5)begin//blt
                 if(register[buyruk[19:15]]<register[buyruk[24:20]])begin
                    ps_Tutucu=buyruk[31:20];
                 end  
                 else begin 
                     ps_Tutucu=ps+4;
                 end                
            end     
        end
        /////////////////////////////////////////////////////
        else if(buyruk[6:0]==111)begin//jal
            register[buyruk[11:5]]=ps+4;
            ps_Tutucu=register[buyruk[19:15]];
        end
        /////////////////////////////////////////////////////
    end  
        
    end
    
    
    
    
    
    
    
endmodule
