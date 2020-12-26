# Define clocks
create_clock -name {pll_clk} -period 20.833333 [get_ports sysclk_1]
create_clock -name {usb_clk} -period 20.833333 [get_ports sysclk_2]
create_clock -name {vga_clk} -period 39.8 [get_pins sysctl/vga_pll/outglobal_o]
create_clock -name {sys_clk} -period 79.6 [get_nets sysctl/clk_div_r]
# set_clock_groups -group [get_clocks sysclk_1] -group [get_clocks usb_clk] -group [get_clocks vga_clk] -group [get_clocks sys_clk] -asynchronous

# Make clocks independent
set_clock_groups -group [get_clocks usb_clk] -group [get_clocks vga_clk] -group [get_clocks sys_clk] -asynchronous

# VGA clock domain
set_output_delay 10 -clock [get_clocks vga_clk] [get_ports {vga_r[0] vga_r[1] vga_r[2] vga_r[3] vga_g[0] vga_g[1] vga_g[2] vga_g[3] vga_b[0] vga_b[1] vga_b[2] vga_b[3] vga_hsync vga_vsync}]

# System clock domain
set_output_delay 10 -clock [get_clocks sys_clk] [get_ports {flash_sck flash_mosi flash_ssel_n sd_sck sd_mosi sd_ssel_n}]
set_input_delay  10 -clock [get_clocks sys_clk] [get_ports {flash_miso sd_miso}]

set_output_delay 10 -clock [get_clocks sys_clk] [get_ports {led}]
set_input_delay  10 -clock [get_clocks sys_clk] [get_ports {button}]

set_input_delay  10 -clock [get_clocks sys_clk] [get_ports {exp3}]

# USB clock domain
set_output_delay -5 -clock [get_clocks usb_clk] [get_ports {usb1_dp usb1_dm usb2_dp usb2_dm}]
set_input_delay  -5 -clock [get_clocks usb_clk] [get_ports {usb1_dp usb1_dm usb2_dp usb2_dm}]

set_output_delay -10 -clock [get_clocks usb_clk] [get_ports {dbg_txd wifi_txd wifi_rts}]
set_input_delay  -10 -clock [get_clocks usb_clk] [get_ports {dbg_rxd wifi_rxd wifi_cts}]

set_output_delay 10 -clock [get_clocks usb_clk] [get_ports {audio_l audio_r}]
