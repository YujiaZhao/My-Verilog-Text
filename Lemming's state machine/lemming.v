module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging);
    parameter E=4'b0000;//fly pia
    parameter D=4'b1000;//dig
    parameter C=4'b0100;//ahh
    parameter B=4'b0010;//right
    parameter A=4'b0001;//left
     
    reg [3:0]state;
    reg [3:0]next_state;

    integer fly;
    initial 
    begin
    state<=A;
    walk_left<=1;
    walk_right<=0;
    aaah<=0;
    digging<=0;
    fly<=0;
    end
   
    always@(posedge clk)begin    
        if(areset) state<=A;
        else if(dig&!aaah) state<=D;
        else if(!ground) begin state<=C;fly=fly+1;end
        else if(fly>20)state<=E;
        else if((fly<=20)&&ground)state<=A;
        else next_state<=state;
    
    always @(fly or state or bump_left or bump_right or ground or dig)begin
    
    case(state)
    E:begin
          next_state<=E;
      end
    D:begin
          next_state<=D;
      end
    C:begin
          next_state=C; 
      end
    B:begin 
          if(bump_right)next_state=A;
          else next_state=B;
      end
    A:begin
          if(bump_left)next_state=B;
          else next_state=A;
      end
    endcase
    end

    
    always@(state)
    
    case(state)
    A:begin
          walk_left<=1'b1;
          walk_right<=1'b0;
          aaah<=1'b0;
          digging<=1'b0;
      end
    B:begin
          walk_left=1'b0;
          walk_right=1'b1;
          aaah=1'b0;
          digging<=1'b0;
      end
    C:begin
          walk_left=1'b0;
          walk_right=1'b0;
          aaah=1'b1;
          digging<=1'b0;
      end
    D:begin
          walk_left=1'b0;
          walk_right=1'b0;
          aaah=1'b0;
          digging=1'b1;
      end
    E:begin
          walk_left=1'b0;
          walk_right=1'b0;
          aaah=1'b0;
          digging=1'b0;
          end
    endcase
endmodule
