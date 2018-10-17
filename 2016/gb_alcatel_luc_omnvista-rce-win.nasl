###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_alcatel_luc_omnvista-rce-win.nasl 11702 2018-10-01 07:31:38Z asteins $
#
# Alcatel Lucent Omnivista 8770 - Remote Code Execution Vulnerability (Windows)
#
# Authors:
# Tameem Eissa <tameem.eissa@greenbone.net>
#
# Copyright:
# Copyright (C) 2016 Greenbone Networks GmbH http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

CPE = "cpe:/a:alcatel-lucent:omnivista";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.107112");
  script_version("$Revision: 11702 $");
  script_cve_id("CVE-2016-9796");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2018-10-01 09:31:38 +0200 (Mon, 01 Oct 2018) $");
  script_tag(name:"creation_date", value:"2016-12-23 13:00:46 +0530 (Fri, 23 Dec 2016)");
  script_tag(name:"qod_type", value:"remote_vul");
  script_name("Alcatel Lucent Omnivista 8770 - Remote Code Execution Vulnerability (Windows)");

  script_tag(name:"summary", value:"This host is installed with Alcatel Lucent Omnivista 8770  and is prone to a remote command execution vulnerability.");

  script_tag(name:"vuldetect", value:"Send a crafted giop packet request and check the response");

  script_tag(name:"insight", value:"The flaw is due to the fact that determined ORBs are exposed and they can be invoked without authentication.");

  script_tag(name:"impact", value:"Successful exploitation will allow
  remote attackers to execute arbitrary code.");

  script_tag(name:"affected", value:"Alcatel Lucent Omnivista 8770 2.0, 2.6 and 3.0");

  script_tag(name:"solution", value:"The vendor position is to refer to the technical guidelines of the product security deployment to mitigate this issue,
  which means applying proper firewall rules to prevent unauthorised clients to connect to the Omnivista server.");

  script_tag(name:"solution_type", value:"Workaround");

  script_xref(name:"URL", value:"http://blog.malerisch.net/2016/12/alcatel-omnivista-8770-unauth-rce-giop-corba.html");
  script_xref(name:"URL", value:"https://www.exploit-db.com/exploits/40862/");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_alcatel_luc_omnvista_detect.nasl", "os_detection.nasl");
  script_require_ports("Services/www", 80, 30024);
  script_mandatory_keys("alc-luc-omnvista/installed", "Host/runs_windows");

  exit(0);
}

include("host_details.inc");

if( ! port = get_app_port( cpe:CPE ) ) exit( 0 );

if ( ! Ver = get_app_version( cpe:CPE, port: port)) exit( 0 );
if ( Ver != "8770" ) exit ( 0 );
giopport = 30024;
if( ! get_port_state( giopport ) ) exit( 0 );
soc = open_sock_tcp( giopport );
if( ! soc ) exit( 0 );
req = raw_string( 0x47, 0x49, 0x4f, 0x50, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x01, 0x26, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x13, 0x53, 0x63, 0x68, 0x65,
0x64, 0x75, 0x6c, 0x65, 0x72, 0x49, 0x6e, 0x74,
0x65, 0x72, 0x66, 0x61, 0x63, 0x65, 0x00, 0x00,
0x00, 0x00, 0x00, 0x0a, 0x41, 0x64, 0x64, 0x4a,
0x6f, 0x62, 0x53, 0x65, 0x74, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
0x4d, 0x59, 0x4a, 0x4f, 0x42, 0x30, 0x31, 0x00,
0x00, 0x00, 0x07, 0xe0, 0x00, 0x00, 0x00, 0x06,
0x00, 0x00, 0x00, 0x1b, 0x00, 0x00, 0x00, 0x10,
0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x08, 0x31, 0x31, 0x31, 0x31,
0x31, 0x31, 0x31, 0x00, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x3f, 0x75, 0x69, 0x64, 0x3d,
0x78, 0x78, 0x78, 0x2e, 0x79, 0x2e, 0x7a, 0x7a,
0x7a, 0x7a, 0x7a, 0x2c, 0x63, 0x6e, 0x3d, 0x41,
0x64, 0x6d, 0x69, 0x6e, 0x69, 0x73, 0x74, 0x72,
0x61, 0x74, 0x6f, 0x72, 0x73, 0x2c, 0x63, 0x6e,
0x3d, 0x38, 0x37, 0x37, 0x30, 0x20, 0x61, 0x64,
0x6d, 0x69, 0x6e, 0x69, 0x73, 0x74, 0x72, 0x61,
0x74, 0x69, 0x6f, 0x6e, 0x2c, 0x6f, 0x3d, 0x6e,
0x6d, 0x63, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
0x6f, 0x6d, 0x6e, 0x69, 0x76, 0x69, 0x73, 0x62,
0x62, 0x00);

send( socket:soc, data:req );
sleep( 5 );
res = recv( socket:soc, length:4096 );
len = strlen( res );
if( ! len ) exit( 0 );
data = "";
for( i = 0; i < len; i = i + 1 ) {
  if( ( ord( res[i] ) >= 61 ) ) {
    data = data + res[i];
  }
}

if( data !~ "GIOP.IDLschedulerutilnmdalcatelcomSCHEDJobSetOMNIVISTAOMNIVISTAHuQ") exit ( 0 );

req2 = raw_string("0x47, 0x49, 0x4f, 0x50, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00,
0xef, 0x0e, 0x5d, 0x58, 0x98, 0xf8, 0x0a, 0x00,
0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07,
0x41, 0x63, 0x74, 0x69, 0x76, 0x65, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00");

send( socket:soc, data:req2 );
sleep( 5 );
res = recv( socket:soc, length:4096 );
len = strlen( res );
if( ! len ) exit( 0 );
data = "";
for( i = 0; i < len; i = i + 1 ) {
  if( ( ord( res[i] ) >= 61 ) ) {
    data = data + res[i];
  }
}

close( soc );
if( data =~ "GIOPGIOP") {
  security_message( port:giopport);
  exit( 0 );
}

exit( 99 );