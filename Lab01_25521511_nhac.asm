# ==============================================================================
# Giao dien thanh ghi ($s* da dung):
#   $s0 : Con tro duyet mang cao do (pitch)
#   $s1 : Con tro duyet mang do dai nh?p (duration)
#   $s2 : Bien dem so not con lai (bat dau tu 15 giam ve 0)
#   $s3 : Bien tich luy tong thoi luong du kien (ms)
#   $s4 : Thoi gian bat dau do bang syscall 30 (ms)
# ==============================================================================

        .data
pitch_arr:  .word   64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62

duration_arr: .word 2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  3,  1,  4

msg_not:    .asciiz "Cao do: "
msg_ms:     .asciiz " | Do dai: "
msg_ms_unit: .asciiz " ms\n"
msg_tong:   .asciiz "Tong du kien (ms) : "
msg_thucte: .asciiz "Thoi gian do duoc (ms) : "
endl:       .asciiz "\n"

        .text
main:
        li      $v0, 30
        syscall
        move    $s4, $a0                
        # 2. Khoi tao cac bien
        la      $s0, pitch_arr          
        la      $s1, duration_arr       
        li      $s2, 15                
        li      $s3, 0                  

loop_nhac:
        beq     $s2, $zero, ket_thuc_nhac 

        lw      $t0, 0($s0)             
        lw      $t1, 0($s1)             

        addi    $t2, $t0, 1             

  
 
        sll     $t3, $t1, 7             
        sll     $t4, $t1, 5            
        addu    $t3, $t3, $t4           

        addu    $s3, $s3, $t3

        la      $a0, msg_not
        li      $v0, 4
        syscall

        move    $a0, $t2            
        li      $v0, 1
        syscall

        la      $a0, msg_ms
        li      $v0, 4
        syscall

        move    $a0, $t3              
        li      $v0, 1
        syscall

        la      $a0, msg_ms_unit
        li      $v0, 4
        syscall


        move    $a0, $t2               
        move    $a1, $t3
        li      $a2, 24                  
        li      $a3, 100                
        li      $v0, 33             
        syscall
        



        addi    $s0, $s0, 4             
        addi    $s1, $s1, 4             
        addi    $s2, $s2, -1            
        j       loop_nhac

ket_thuc_nhac:
        li      $v0, 30
        syscall
        subu    $t5, $a0, $s4           


        la      $a0, endl
        li      $v0, 4
        syscall

        la      $a0, msg_tong
        li      $v0, 4
        syscall

        move    $a0, $s3
        li      $v0, 1
        syscall

        la      $a0, endl
        li      $v0, 4
        syscall

        la      $a0, msg_thucte
        li      $v0, 4
        syscall

        move    $a0, $t5
        li      $v0, 1
        syscall

        la      $a0, endl
        li      $v0, 4
        syscall

        li      $v0, 10
        syscall