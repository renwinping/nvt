###############################################################################
# OpenVAS Vulnerability Test
# $Id: ventrilo_detect.nasl 11018 2018-08-17 07:13:05Z cfischer $
#
# Ventrilo Server Detection
#
# Authors:
# Tenable Network Security
#
# Copyright:
# Copyright (C) 2005-2008 Tenable Network Security
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2,
# as published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.80092");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_version("$Revision: 11018 $");
  script_tag(name:"last_modification", value:"$Date: 2018-08-17 09:13:05 +0200 (Fri, 17 Aug 2018) $");
  script_tag(name:"creation_date", value:"2008-10-24 23:33:44 +0200 (Fri, 24 Oct 2008)");
  script_tag(name:"cvss_base", value:"0.0");
  script_name("Ventrilo Server Detection");
  script_category(ACT_GATHER_INFO);
  script_family("Service detection");
  script_copyright("This script is Copyright (C) 2005-2008 Tenable Network Security");
  script_require_udp_ports(3784);

  script_xref(name:"URL", value:"http://www.ventrilo.com/");

  script_tag(name:"solution", value:"Make sure the use of this software is made in accordance to your local
  security policy since Ventrilo is often associated with multi-player online games.");

  script_tag(name:"summary", value:"A VoIP service is listening on the remote host.

  Description :

  The remote host is running Ventrilo, a voice over IP (VoIP) software developed by Flagship Industries.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("cpe.inc");
include("host_details.inc");

SCRIPT_DESC = "Ventrilo Server Detection";

port = 3784;
if (!get_udp_port_state(port)) exit(0);

# nb: fetch big-endian 16-bit value (string s, offset o)
# nb: taken from dns_xfer.nasl.
function ntohs(s, o) {
  local_var ret_hi, ret_lo;
  ret_hi = ord(s[o]) << 8;
  ret_lo = ord(s[o+1]);
  return (ret_hi + ret_lo);
}

# See <http://aluigi.altervista.org/papers.htm#ventrilo>, especially
# the UDP status algorithm 0.1 and the status retriever 0.1.

MAXPCK = 32;
MAXPCKSZ = 492;

ventrilo_udp_encdata_head = make_list(
  0x80, 0xe5, 0x0e, 0x38, 0xba, 0x63, 0x4c, 0x99, 0x88, 0x63, 0x4c, 0xd6, 0x54, 0xb8, 0x65, 0x7e,
  0xbf, 0x8a, 0xf0, 0x17, 0x8a, 0xaa, 0x4d, 0x0f, 0xb7, 0x23, 0x27, 0xf6, 0xeb, 0x12, 0xf8, 0xea,
  0x17, 0xb7, 0xcf, 0x52, 0x57, 0xcb, 0x51, 0xcf, 0x1b, 0x14, 0xfd, 0x6f, 0x84, 0x38, 0xb5, 0x24,
  0x11, 0xcf, 0x7a, 0x75, 0x7a, 0xbb, 0x78, 0x74, 0xdc, 0xbc, 0x42, 0xf0, 0x17, 0x3f, 0x5e, 0xeb,
  0x74, 0x77, 0x04, 0x4e, 0x8c, 0xaf, 0x23, 0xdc, 0x65, 0xdf, 0xa5, 0x65, 0xdd, 0x7d, 0xf4, 0x3c,
  0x4c, 0x95, 0xbd, 0xeb, 0x65, 0x1c, 0xf4, 0x24, 0x5d, 0x82, 0x18, 0xfb, 0x50, 0x86, 0xb8, 0x53,
  0xe0, 0x4e, 0x36, 0x96, 0x1f, 0xb7, 0xcb, 0xaa, 0xaf, 0xea, 0xcb, 0x20, 0x27, 0x30, 0x2a, 0xae,
  0xb9, 0x07, 0x40, 0xdf, 0x12, 0x75, 0xc9, 0x09, 0x82, 0x9c, 0x30, 0x80, 0x5d, 0x8f, 0x0d, 0x09,
  0xa1, 0x64, 0xec, 0x91, 0xd8, 0x8a, 0x50, 0x1f, 0x40, 0x5d, 0xf7, 0x08, 0x2a, 0xf8, 0x60, 0x62,
  0xa0, 0x4a, 0x8b, 0xba, 0x4a, 0x6d, 0x00, 0x0a, 0x93, 0x32, 0x12, 0xe5, 0x07, 0x01, 0x65, 0xf5,
  0xff, 0xe0, 0xae, 0xa7, 0x81, 0xd1, 0xba, 0x25, 0x62, 0x61, 0xb2, 0x85, 0xad, 0x7e, 0x9d, 0x3f,
  0x49, 0x89, 0x26, 0xe5, 0xd5, 0xac, 0x9f, 0x0e, 0xd7, 0x6e, 0x47, 0x94, 0x16, 0x84, 0xc8, 0xff,
  0x44, 0xea, 0x04, 0x40, 0xe0, 0x33, 0x11, 0xa3, 0x5b, 0x1e, 0x82, 0xff, 0x7a, 0x69, 0xe9, 0x2f,
  0xfb, 0xea, 0x9a, 0xc6, 0x7b, 0xdb, 0xb1, 0xff, 0x97, 0x76, 0x56, 0xf3, 0x52, 0xc2, 0x3f, 0x0f,
  0xb6, 0xac, 0x77, 0xc4, 0xbf, 0x59, 0x5e, 0x80, 0x74, 0xbb, 0xf2, 0xde, 0x57, 0x62, 0x4c, 0x1a,
  0xff, 0x95, 0x6d, 0xc7, 0x04, 0xa2, 0x3b, 0xc4, 0x1b, 0x72, 0xc7, 0x6c, 0x82, 0x60, 0xd1, 0x0d
);

ventrilo_udp_encdata_data = make_list(
  0x82, 0x8b, 0x7f, 0x68, 0x90, 0xe0, 0x44, 0x09, 0x19, 0x3b, 0x8e, 0x5f, 0xc2, 0x82, 0x38, 0x23,
  0x6d, 0xdb, 0x62, 0x49, 0x52, 0x6e, 0x21, 0xdf, 0x51, 0x6c, 0x76, 0x37, 0x86, 0x50, 0x7d, 0x48,
  0x1f, 0x65, 0xe7, 0x52, 0x6a, 0x88, 0xaa, 0xc1, 0x32, 0x2f, 0xf7, 0x54, 0x4c, 0xaa, 0x6d, 0x7e,
  0x6d, 0xa9, 0x8c, 0x0d, 0x3f, 0xff, 0x6c, 0x09, 0xb3, 0xa5, 0xaf, 0xdf, 0x98, 0x02, 0xb4, 0xbe,
  0x6d, 0x69, 0x0d, 0x42, 0x73, 0xe4, 0x34, 0x50, 0x07, 0x30, 0x79, 0x41, 0x2f, 0x08, 0x3f, 0x42,
  0x73, 0xa7, 0x68, 0xfa, 0xee, 0x88, 0x0e, 0x6e, 0xa4, 0x70, 0x74, 0x22, 0x16, 0xae, 0x3c, 0x81,
  0x14, 0xa1, 0xda, 0x7f, 0xd3, 0x7c, 0x48, 0x7d, 0x3f, 0x46, 0xfb, 0x6d, 0x92, 0x25, 0x17, 0x36,
  0x26, 0xdb, 0xdf, 0x5a, 0x87, 0x91, 0x6f, 0xd6, 0xcd, 0xd4, 0xad, 0x4a, 0x29, 0xdd, 0x7d, 0x59,
  0xbd, 0x15, 0x34, 0x53, 0xb1, 0xd8, 0x50, 0x11, 0x83, 0x79, 0x66, 0x21, 0x9e, 0x87, 0x5b, 0x24,
  0x2f, 0x4f, 0xd7, 0x73, 0x34, 0xa2, 0xf7, 0x09, 0xd5, 0xd9, 0x42, 0x9d, 0xf8, 0x15, 0xdf, 0x0e,
  0x10, 0xcc, 0x05, 0x04, 0x35, 0x81, 0xb2, 0xd5, 0x7a, 0xd2, 0xa0, 0xa5, 0x7b, 0xb8, 0x75, 0xd2,
  0x35, 0x0b, 0x39, 0x8f, 0x1b, 0x44, 0x0e, 0xce, 0x66, 0x87, 0x1b, 0x64, 0xac, 0xe1, 0xca, 0x67,
  0xb4, 0xce, 0x33, 0xdb, 0x89, 0xfe, 0xd8, 0x8e, 0xcd, 0x58, 0x92, 0x41, 0x50, 0x40, 0xcb, 0x08,
  0xe1, 0x15, 0xee, 0xf4, 0x64, 0xfe, 0x1c, 0xee, 0x25, 0xe7, 0x21, 0xe6, 0x6c, 0xc6, 0xa6, 0x2e,
  0x52, 0x23, 0xa7, 0x20, 0xd2, 0xd7, 0x28, 0x07, 0x23, 0x14, 0x24, 0x3d, 0x45, 0xa5, 0xc7, 0x90,
  0xdb, 0x77, 0xdd, 0xea, 0x38, 0x59, 0x89, 0x32, 0xbc, 0x00, 0x3a, 0x6d, 0x61, 0x4e, 0xdb, 0x29
);

function ventrilo_udp_head_dec(data) {
  # nb: a1 and a2 are supposed to be chars so truncate as necessary.
  local_var i, p, a1, a2;
  local_var c, j;

  j = 0;
  p = ntohs(s:data, o:j);
  c = data[j];
  data = insstr(data, data[j+1], j, j);
  data = insstr(data, c, j+1, j+1);
  j += 2;
  a1 = p % 256;
  if (!a1) return NULL;
  a2 = (p >> 8) % 256;

  for (i = 0; i < 18; i++) {
    c = raw_string(ord(data[i+j]) - (ventrilo_udp_encdata_head[a2] + (i % 5)));
    data = insstr(data, c, i+j, i+j);
    a2 = (a2 + a1) % 256;
  }

  for (i = 0; i < 9; i++) {
    c = data[j];
    data = insstr(data, data[j+1], j, j);
    data = insstr(data, c, j+1, j+1);
    j += 2;
  }

  return data;
}

function ventrilo_udp_data_dec(data, len, key) {
  # nb: a1 and a2 are supposed to be chars so truncate as necessary.
  local_var i, a1, a2;
  local_var c;

  a1 = key % 256;
  if (!a1) return NULL;
  a2 = (key >> 8) % 256;

  for (i = 0; i < len; i++) {
    c = raw_string(ord(data[i]) - (ventrilo_udp_encdata_data[a2] + (i % 72)));
    data = insstr(data, c, i, i);
    a2 = (a2 + a1) % 256;
  }

  return data;
}

function ventrilo_udp_crc(data, len) {
  local_var crc, i, table;

  table = make_list(
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
    0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
    0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
    0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
    0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
    0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
    0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
    0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
    0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
    0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
    0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
    0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
    0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
    0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
    0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
    0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
    0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
    0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
    0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
    0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
    0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
    0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
    0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
  );

  crc = 0;
  for (i=0; i < len; i++) {
    short = ord(data[i]);
    crc = table[crc >> 8] ^ short ^ (crc << 8);
  }

  return(crc);
}


# Send a status request with command code 2.
#
# nb: this came from ventstat and will change each time you run it.
req = raw_string(
  0x6f, 0x03, 0xae, 0x41, 0x77, 0x87, 0x7d, 0x8c, 0x65, 0xea, 0x22, 0x0b, 0xf8, 0xa2, 0xbc, 0x03,
  0xa5, 0x0a, 0xf6, 0xb0, 0x36, 0xe0, 0x93, 0xd0, 0x4e, 0x82, 0x1b, 0xb8, 0x19, 0x6f, 0x91, 0x3a,
  0x7f, 0x04, 0xe7, 0x07
);

soc = open_sock_udp(port);
if (!soc) exit(0);
send(socket:soc, data:req);

# Read and decode the response.
i = 0;
totlen = 0;
full = "";
while (1) {
  buff = recv(socket:soc, length:MAXPCKSZ+20);
  if (isnull(buff)) break;
  buff = ventrilo_udp_head_dec(data:buff);

  stat_id      = ord(buff[6])  + (ord(buff[6+1]) << 8);
  stat_totlen  = ord(buff[8])  + (ord(buff[8+1]) << 8);
  stat_len     = ord(buff[10]) + (ord(buff[10+1]) << 8);
  stat_totpck  = ord(buff[12]) + (ord(buff[12+1]) << 8);
  stat_pck     = ord(buff[14]) + (ord(buff[14+1]) << 8);
  stat_datakey = ord(buff[16]) + (ord(buff[16+1]) << 8);
  stat_crc     = ord(buff[18]) + (ord(buff[18+1]) << 8);

  if (
    strlen(buff) < 20 ||
    stat_totpck < stat_pck ||
    stat_totpck > MAXPCK ||
    stat_len > MAXPCKSZ
  ) {
    if (log_verbosity > 1) debug_print("wrong or incomplete reply received.", level:0);
    exit(1);
  }

  len = stat_len;
  totlen += len;
  if (totlen > (MAXPCKSZ * MAXPCK)) break;

  data = substr(buff, 20);
  data = ventrilo_udp_data_dec(data:data, len:len, key:stat_datakey);
  full = raw_string(full, data);

  if (++i == stat_totpck) break;
  if (totlen == stat_totlen) break;
}

# Extract the version number and report if found.
if (full) {
  ver = strstr(full, "VERSION: ");
  if (ver) {
    ver = ver - "VERSION: ";
    ver = ver - strstr(ver, '\n');
    set_kb_item(name:"Ventrilo/version", value:ver);
  } else {
    ver = "unknown";
  }

  cpe = build_cpe(value:ver, exp:"^([0-9.]+)", base:"cpe:/a:flagship_industries:ventrilo:");
  if (isnull(cpe))
    cpe = "cpe:/a:flagship_industries:ventrilo";

  log_message(data:build_detection_report(app:"Ventrilo server",
                                          version:ver,
                                          install:port,
                                          cpe:cpe,
                                          concluded:full),
                                          port:port, protocol:"udp");

  # nb: Ventrilo uses the same port number for both UDP and TCP.
  register_service(port:port, ipproto:"udp", proto:"ventrilo");
  register_service(port:port, ipproto:"tcp", proto:"ventrilo");
}

exit( 0 );