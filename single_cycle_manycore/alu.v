//-----------------------------------------------------------------------------
// Title         : ALU Behavioral Model
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : alu.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Behavioral model of the ALU used in the implementations of the MIPS processor
//   subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the function specified on p. 301 of COD3e.
//
//-----------------------------------------------------------------------------

module alu(ctl, a, b, shamt, result, zero);
  input [2:0] ctl;
  input [31:0] a, b;       // RS -> a, RT -> b
  input [4:0] shamt;
  output [31:0] result;    // RD <- result
  output zero;

  reg [31:0] result;
  reg zero;

  always @(a or b or ctl)
  begin
    case (ctl)
      3'b000 : result = a & b; // AND
      3'b001 : result = a | b; // OR
      3'b010 : result = a + b; // ADD
      3'b110 : result = a - b; // SUBTRACT
      3'b111 : if (a < b) result = 32'd1; 
               else result = 32'd0; //SLT   
      3'b100 : result = b << shamt; // SLL
      3'b101 : result = b >> shamt; // SRL
      default : result = 32'hxxxxxxxx;
    endcase
    
    if (result == 32'd0) zero = 1;
    else zero = 0;
  end
  
  always @(a or b or ctl)
  begin
    if ( ctl == 3'b101 )
      $display("SRL:: a:%d, b:%d, shamt:%d, result:%d", a, b, shamt, result);
  end
endmodule

