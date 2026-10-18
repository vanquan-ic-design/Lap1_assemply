# ==============================================================================
# Giao dien thanh ghi ($s* da dung):
#   $s0 : So dien nang tieu thu x (kWh) do nguoi dung nhap (0 <= x <= 9999)
#   $s1 : Tong tien dien tich luy (dong)
#   $s2 : Con tro dia chi duyet mang nguong cac bac (nguong)
#   $s3 : Con tro dia chi duyet mang don gia (don_gia)
#   $s4 : Moc nguong tren cua bac lien truoc (moc_truoc)
# ==============================================================================

        .data
nguong:     .word   50, 100, 200, 300, 400, 9999
don_gia:    .word   1620, 1680, 1970, 2520, 2870, 3020

msg_nhap:   .asciiz "Nhap so kWh (0..9999): "
msg_loi:    .asciiz "Gia tri khong hop le, nhap lai.\n"
msg_xuat1:  .asciiz "Tien dien: "
msg_xuat2:  .asciiz " dong\n"

        .text
main:
nhap_loop:
       
        la      $a0, msg_nhap
        li      $v0, 4
        syscall

        li      $v0, 5
        syscall
        move    $s0, $v0                

        sltiu   $t0, $s0, 10000         
        bne     $t0, $zero, tinh_tien  

        la      $a0, msg_loi
        li      $v0, 4
        syscall
        j       nhap_loop

tinh_tien:
        li      $s1, 0                  
        la      $s2, nguong             
        la      $s3, don_gia           
        li      $s4, 0                 

loop_bac:
        lw      $t0, 0($s2)             
        lw      $t1, 0($s3)             

        slt     $t2, $s0, $t0           
        bne     $t2, $zero, tinh_phan_du 

        subu    $t3, $t0, $s4           
        mul     $t4, $t3, $t1          
        addu    $s1, $s1, $t4          
        
        move    $s4, $t0               
        addiu   $s2, $s2, 4             
        addiu   $s3, $s3, 4             
        j       loop_bac               

tinh_phan_du:

        subu    $t3, $s0, $s4          
        mul     $t4, $t3, $t1           
        addu    $s1, $s1, $t4           
        j       xuat_kq

xuat_kq:

        la      $a0, msg_xuat1
        li      $v0, 4
        syscall


        move    $a0, $s1
        li      $v0, 1
        syscall


        la      $a0, msg_xuat2
        li      $v0, 4
        syscall

        li      $v0, 10
        syscall
