source $::env(SCRIPTS_DIR)/openroad/common/io.tcl

read_current_odb

set IO_LENGTH 355
set IO_WIDTH 75
set IO_OFFSET 20.3
set MAX_NUM_PADS_HORIZONTAL 11
set MAX_NUM_PADS_VERTICAL 21

set PAD_IDX_OFFSET 1
set PAD_IDX_COUNT [expr ($MAX_NUM_PADS_HORIZONTAL + $MAX_NUM_PADS_VERTICAL)*2]

proc calc_horizontal_pad_location {index} {
	global IO_LENGTH
	global IO_WIDTH
	global IO_OFFSET
	global MAX_NUM_PADS_HORIZONTAL

	set DIE_WIDTH [expr {[lindex $::env(DIE_AREA) 2] - [lindex $::env(DIE_AREA) 0]}]
	set PAD_OFFSET [expr {$IO_LENGTH + $IO_OFFSET}]
	set PAD_AREA_WIDTH [expr {$DIE_WIDTH - ($PAD_OFFSET * 2)}]
	set SPACE_WIDTH [expr {$PAD_AREA_WIDTH - ($IO_WIDTH * $MAX_NUM_PADS_HORIZONTAL)}]
	set HORIZONTAL_PAD_DISTANCE [expr {floor($SPACE_WIDTH / ($MAX_NUM_PADS_HORIZONTAL + 1))}]
	set SPACE_LEFT [expr {$SPACE_WIDTH - $HORIZONTAL_PAD_DISTANCE * ($MAX_NUM_PADS_HORIZONTAL - 1)}]

	return [expr {$PAD_OFFSET + ($SPACE_LEFT / 2) + (($IO_WIDTH + $HORIZONTAL_PAD_DISTANCE) * $index)}]
}

proc calc_vertical_pad_location {index} {
	global IO_LENGTH
	global IO_WIDTH
	global IO_OFFSET
	global MAX_NUM_PADS_VERTICAL

	set DIE_HEIGHT [expr {[lindex $::env(DIE_AREA) 3] - [lindex $::env(DIE_AREA) 1]}]
	set PAD_OFFSET [expr {$IO_LENGTH + $IO_OFFSET}]
	set PAD_AREA_HEIGHT [expr {$DIE_HEIGHT - ($PAD_OFFSET * 2)}]
	set SPACE_HEIGHT [expr {$PAD_AREA_HEIGHT - ($IO_WIDTH * $MAX_NUM_PADS_VERTICAL)}]
	set VERTICAL_PAD_DISTANCE [expr {floor($SPACE_HEIGHT / ($MAX_NUM_PADS_VERTICAL + 1))}]
	set SPACE_LEFT [expr {$SPACE_HEIGHT - $VERTICAL_PAD_DISTANCE * ($MAX_NUM_PADS_VERTICAL - 1)}]

	return [expr {$PAD_OFFSET + ($SPACE_LEFT / 2) + (($IO_WIDTH + $VERTICAL_PAD_DISTANCE) * $index)}]
}

make_fake_io_site -name IOLibSite -width 1 -height $IO_LENGTH
make_fake_io_site -name IOLibCSite -width $IO_LENGTH -height $IO_LENGTH

make_io_sites \
    -horizontal_site IOLibSite \
    -vertical_site IOLibSite \
    -corner_site IOLibCSite \
    -offset $IO_OFFSET

place_pad -row IO_WEST -location [calc_vertical_pad_location 20] {pad_w_20}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 19] {pad_w_19}  -master gf180mcu_fd_io__dvdd
place_pad -row IO_WEST -location [calc_vertical_pad_location 18] {pad_w_18}  -master gf180mcu_fd_io__dvdd
place_pad -row IO_WEST -location [calc_vertical_pad_location 17] {pad_w_17}  -master gf180mcu_fd_io__dvss
place_pad -row IO_WEST -location [calc_vertical_pad_location 16] {pad_w_16}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 15] {pad_w_15}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 14] {pad_w_14}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 13] {pad_w_13}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 12] {pad_w_12}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 11] {pad_w_11} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location 10] {pad_w_10} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  9] {pad_w_9} -master gf180mcu_fd_io__dvdd
place_pad -row IO_WEST -location [calc_vertical_pad_location  8] {pad_w_8} -master gf180mcu_fd_io__dvss
place_pad -row IO_WEST -location [calc_vertical_pad_location  7] {pad_w_7} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  6] {pad_w_6} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  5] {pad_w_5} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  4] {pad_w_4} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  3] {pad_w_3} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  2] {pad_w_2} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_WEST -location [calc_vertical_pad_location  1] {pad_w_1} -master gf180mcu_fd_io__dvdd
place_pad -row IO_WEST -location [calc_vertical_pad_location  0] {pad_w_0} -master gf180mcu_fd_io__dvdd

place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  0] {pad_s_0}  -master gf180mcu_fd_io__dvss
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  1] {pad_s_1}  -master gf180mcu_fd_io__in_c
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  2] {pad_s_2}  -master gf180mcu_fd_io__in_c
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  3] {pad_s_3}  -master gf180mcu_fd_io__dvss
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  4] {pad_s_4}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  5] {pad_s_5}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  6] {pad_s_6}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  7] {pad_s_7}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  8] {pad_s_8}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  9] {pad_s_9}  -master gf180mcu_fd_io__dvss
place_pad -row IO_SOUTH -location [calc_horizontal_pad_location  10] {pad_s_10}  -master gf180mcu_fd_io__dvdd

place_pad -row IO_EAST -location [calc_vertical_pad_location  0] {pad_e_0}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  1] {pad_e_1}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  2] {pad_e_2}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  3] {pad_e_3}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  4] {pad_e_4}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  5] {pad_e_5}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  6] {pad_e_6}  -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location  7] {pad_e_7}  -master gf180mcu_fd_io__dvss
place_pad -row IO_EAST -location [calc_vertical_pad_location  8] {pad_e_8}  -master gf180mcu_fd_io__dvss
place_pad -row IO_EAST -location [calc_vertical_pad_location  9] {pad_e_9}  -master gf180mcu_fd_io__dvdd
place_pad -row IO_EAST -location [calc_vertical_pad_location 10] {pad_e_10} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 11] {pad_e_11} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 12] {pad_e_12} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 13] {pad_e_13} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 14] {pad_e_14} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 15] {pad_e_15} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 16] {pad_e_16} -master gf180mcu_fd_io__dvdd
place_pad -row IO_EAST -location [calc_vertical_pad_location 17] {pad_e_17} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_EAST -location [calc_vertical_pad_location 18] {pad_e_18} -master gf180mcu_fd_io__dvdd
place_pad -row IO_EAST -location [calc_vertical_pad_location 19] {pad_e_19} -master gf180mcu_fd_io__bi_24t

place_pad -row IO_NORTH -location [calc_horizontal_pad_location  10] {pad_n_10} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  9] {pad_n_9} -master gf180mcu_fd_io__dvss
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  8] {pad_n_8} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  7] {pad_n_7} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  6] {pad_n_6} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  5] {pad_n_5} -master gf180mcu_fd_io__dvss
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  4] {pad_n_4} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  3] {pad_n_3} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  2] {pad_n_2} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  1] {pad_n_1} -master gf180mcu_fd_io__bi_24t
place_pad -row IO_NORTH -location [calc_horizontal_pad_location  0] {pad_n_0} -master gf180mcu_fd_io__bi_24t

place_corners gf180mcu_fd_io__cor

set iofill {
    gf180mcu_fd_io__fill10
    gf180mcu_fd_io__fill5
    gf180mcu_fd_io__fill1
}

place_io_fill -row IO_NORTH {*}$iofill
place_io_fill -row IO_SOUTH {*}$iofill
place_io_fill -row IO_WEST {*}$iofill
place_io_fill -row IO_EAST {*}$iofill

connect_by_abutment

place_io_terminals pad_*/PAD
place_io_terminals pad_*/DVSS
place_io_terminals pad_*/DVDD

remove_io_rows

write_views

