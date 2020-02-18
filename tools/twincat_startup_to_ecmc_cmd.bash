
#!/usr/bin/env bash
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
#   author  : Anders Sandström
#   email   : anders.sandstrom@esss.se
#   date    : Monday, February 17 08:06 2020
#   version : 0.0.1
#
# 
# Script converts an exported twincat startup-list, in csv format, to an ecmc command file.
# note: Only supports CoE protocol
# Usage: cat <twincat_startup.csv> | twincat_startup_to_ecmc_cmd.bash | tee <ecmcFilename.cmd>
#
#
# Examples of data rows from TwinCAT startup list
# Transition;Protocol;Index;Data;Comment
# <PS>;CoE;0x1A00 C 0;01 00 20 01 00 60;download pdo 0x1A00 entries
# <PS>;CoE;0x1A01 C 0;03 00 01 01 10 60 07 00 00 00 08 00 00 00;download pdo 0x1A01 entries
# <PS>;CoE;0x1A02 C 0;03 00 01 01 20 60 07 00 00 00 08 00 00 00;download pdo 0x1A02 entries
# <PS>;CoE;0x1A03 C 0;03 00 01 01 30 60 07 00 00 00 08 00 00 00;download pdo 0x1A03 entries
# <PS>;CoE;0x1C12 C 0;00 00;download pdo 0x1C12 index
# <PS>;CoE;0x1C13 C 0;05 00 04 1A 00 1A 01 1A 02 1A 03 1A;download pdo 0x1C13 index
# <IP, PS>;AoE;1/3;C0 A8 58 2C 02 05;AoE Init Cmd (download NetId)
# PS;CoE;0x8000 C 1;02 80 02 00 42 03 00 00 11 2B 0A 00 C3 00 00 00 00 00 23 00;Object 8000
# PS;CoE;0x8010 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8010
# PS;CoE;0x8020 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8020
# PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030
# PS;CoE;0x8030:01;0x00;Object 8030
# PS;CoE;0x8030:10;FALSE;Object 8030
# PS;CoE;0x8030:10;TRUE;Object 8030
# PS;CoE;0x8030:10;TRUE;Object 8030
# PS;CoE;0x8030:1;0x0000;Object 8030
# PS;CoE;0x8030:2;0x00001234;Object 8030

PROTOCOL="CoE"
COMPLETE_CMD="C"
HEADER="Transition;Protocol;Index;Data;Comment"
ECMC_CONFIG_CMD="ecmcConfigOrDie"

# Convert dec to hex (including "0x")
# Arg 1: Value in dec ("10")
function dec_to_hex
{
  printf '0x%x' $1
}

# Extract sdo
# Arg 1: Line from startup list: "PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030"
function get_sdo_index
{
  echo $1 | grep "$PROTOCOL" | awk -F "\"*;\"*" '{print $3}' | awk -F "\"* \"*" '{print $1}'
}

# Extract sdo offset if complete cmd (as hex string)
# Arg 1: Line from startup list "PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030"
function get_sdo_complete_off
{
  local offset=$(echo $1 | grep "$PROTOCOL" | awk -F "\"*;\"*" '{print $3}' | awk -F "\"* \"*" '{print $3}')
  # convert to hex
  echo $(dec_to_hex $offset)
}

# Extract sdo offset if normal sdo (as hex string) 
# Arg 1: Line from startup list "PS;CoE;0x8030:10;TRUE;Object 8030"
function get_sdo_normal_off  
{
  local offset=$(echo $1 | grep "$PROTOCOL" | awk -F "\"*;\"*" '{print $3}' | awk -F "\"*:\"*" '{print $2}')
  # already in hex
  echo "0x$offset"
}

# Extract data string
# Arg 1: Line from startup list "PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030"
function get_sdo_data
{
  echo -e $1 | grep "$PROTOCOL" | awk -F "\"*;\"*" '{print $4}'
}

# # Convert "TRUE" to 0x01 and FALSE to 0x00
# Arg 1: sdo_data "Ox00", "FALSE", "TRUE", "Ox0000" "Ox00001234"
function convert_sdo_binary_data
{ 
  if [ "$1" = "TRUE" ]; then
    echo "0x01"
  elif [ "$1" = "FALSE" ]; then
    echo "0x00"
  else
    echo $1
  fi
}

# Get data byte size for normal sdo commands (1,2 or 4 byte)
# Arg 1: sdo_data "Ox00","Ox0000" "Ox00001234"
function get_sdo_normal_byte_size
{
  # Now only hex numbers (no TRUE or FALSE). Count number of zeros behind "0x" and divide with 2
  local strlen=${#1}
  echo $((($strlen -2)/2))
}

# # Get data byte size for complete cmds
# Arg 1: sdo_data "00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00"
function get_sdo_comlete_byte_size
{  
  local spaces=$(echo $1 | tr -cd ' \t' | wc -c)
  echo $(($spaces + 1))
}

# Determinie if the row is a sdo complete command
# Arg 1: Line from startup list "PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030"
function get_sdo_is_complete_cmd
{  
  local is_complete=$(echo "$1" | grep "$PROTOCOL" | awk -F "\"*;\"*" '{print $3}' | awk -F "\"* \"*" '{print $2}' );
  if [ "${is_complete}" = "$COMPLETE_CMD" ]; then
    echo "1"
  else
    echo "0"
  fi
}

# Printout sdo complete command
# Use "EcAddSdoComplete" if subindex == 0  otherwise use "EcAddSdoBuffer()"
# Arg 1: sdo_index
# Arg 2: sdo_index_offset
# Arg 3: sdo_data
function print_sdo_complete_cmd
{
  local byte_size=$(get_sdo_comlete_byte_size "$sdo_data");
  if [ "$2" = "0x0" ] || [ "$2" = "0x00" ]; then
    echo "$ECMC_CONFIG_CMD \"Cfg.EcAddSdoComplete(\${ECMC_EC_SLAVE_NUM},$1,$3,$byte_size)\""
  else
    echo "$ECMC_CONFIG_CMD \"Cfg.EcAddSdoBuffer(\${ECMC_EC_SLAVE_NUM},$1,$2,$3,$byte_size)\""
  fi
}

# Printout sdo normal command
# Use "EcAddSdo"
# Arg 1: sdo_index
# Arg 2: sdo_index_offset
# Arg 3: sdo_data
function print_sdo_normal_cmd
{
  local sdo_data_local=$(convert_sdo_binary_data "$3")
  local byte_size=$(get_sdo_normal_byte_size "$sdo_data_local");
  echo "$ECMC_CONFIG_CMD \"Cfg.EcAddSdo(\${ECMC_EC_SLAVE_NUM},$1,$2,$sdo_data_local,$byte_size)\""
}

# Get protocol (Column 2)
# Arg 1: Line from startup list "<IP, PS>;AoE;1/3;C0 A8 58 2C 02 05;AoE Init Cmd (download NetId)"
function get_protocol
{ 
  echo -e $1 | awk -F "\"*;\"*" '{print $2}'
}

# Is a valid line
# Arg 1: Line from startup list "PS;CoE;0x8030 C 1;00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 01 00;Object 8030"
function is_valid_line
{ 
  echo $1 | grep $PROTOCOL | wc -l
}

# Is header
# Arg 1: Line from startup list ""Transition;Protocol;Index;Data;Comment"
function is_header
{ 
  echo $1 | grep $HEADER | wc -l
}

###############################################################################
# Main program start
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then    
    echo "twincat_startup_to_ecmc_cmd.bash"
    echo "Script to generate ecmc cmd file from TwinCAT startup list export csv file"
    echo "Currently only CoE are supported"
    echo "Usage:"
    echo "cat <twincat_startup.csv> | twincat_startup_to_ecmc_cmd.bash | tee <ecmcFilename.cmd>"
    exit 0
fi

i=0

while read line; do
  echo "#- "$line

  is_header=$(is_header $line)  
  if [ "$is_header" = "1" ]; then
    echo ""
    continue
  fi

  is_valid=$(is_valid_line $line)
  if [ "$is_valid" != "1" ]; then    
    #echo "#- Warning: Protocol," $(get_protocol $line) ", not supported"
    echo "#- Warning: Protocol not supported"
    echo ""
    continue
  fi

  sdo_index=$(get_sdo_index "$line")
  sdo_data=$(get_sdo_data "$line")  
  sdo_is_complete=$(get_sdo_is_complete_cmd "$line")

  # Complete access or "normal" sdo command
  if [ "${sdo_is_complete}" = "1" ]; then
    sdo_offset=$(get_sdo_complete_off "$line")
    echo $(print_sdo_complete_cmd "$sdo_index" "$sdo_offset" "$sdo_data")
  else
    sdo_offset=$(get_sdo_normal_off "$line")
    echo $(print_sdo_normal_cmd "$sdo_index" "$sdo_offset" "$sdo_data")
  fi
  echo ""
  (( i++ ))
done
