# N = 5
addi $t3, $zero, 0x00 
addi $t1, $zero, 0x05 # N

addi $s0, $zero, 0 # first finbonacci term
addi $s1, $zero, 1 # second term

forloop:
beq  $t3, $t1, endfor # For if
# body for
add $s2, $s0, $s1

add $s0, $s1, $zero
add $s1, $s2, $zero

addi $t3, $t3, 1
j forloop
endfor:
