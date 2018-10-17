###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ubuntu_USN_1883_1.nasl 11037 2018-08-17 11:51:16Z cfischer $
#
# Ubuntu Update for linux-ti-omap4 USN-1883-1
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
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

include("revisions-lib.inc");

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.841481");
  script_version("$Revision: 11037 $");
  script_tag(name:"last_modification", value:"$Date: 2018-08-17 13:51:16 +0200 (Fri, 17 Aug 2018) $");
  script_tag(name:"creation_date", value:"2013-06-18 10:44:50 +0530 (Tue, 18 Jun 2013)");
  script_cve_id("CVE-2013-2850", "CVE-2013-3076", "CVE-2013-3222", "CVE-2013-3223",
                "CVE-2013-3224", "CVE-2013-3225", "CVE-2013-3234", "CVE-2013-3235");
  script_tag(name:"cvss_base", value:"7.9");
  script_tag(name:"cvss_base_vector", value:"AV:A/AC:M/Au:N/C:C/I:C/A:C");
  script_name("Ubuntu Update for linux-ti-omap4 USN-1883-1");

  script_xref(name:"USN", value:"1883-1");
  script_xref(name:"URL", value:"http://www.ubuntu.com/usn/usn-1883-1/");
  script_tag(name:"summary", value:"Check for the Version of linux-ti-omap4");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2013 Greenbone Networks GmbH");
  script_family("Ubuntu Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/ubuntu_linux", "ssh/login/packages", re:"ssh/login/release=UBUNTU13\.04");
  script_tag(name:"affected", value:"linux-ti-omap4 on Ubuntu 13.04");
  script_tag(name:"solution", value:"Please Install the Updated Packages.");
  script_tag(name:"insight", value:"Kees Cook discovered a flaw in the Linux kernel's iSCSI subsystem. A remote
  unauthenticated attacker could exploit this flaw to cause a denial of
  service (system crash) or potentially gain administrative privileges.
  (CVE-2013-2850)

  An information leak was discovered in the Linux kernel's crypto API. A
  local user could exploit this flaw to examine potentially sensitive
  information from the kernel's stack memory. (CVE-2013-3076)

  An information leak was discovered in the Linux kernel's rcvmsg path for
  ATM (Asynchronous Transfer Mode). A local user could exploit this flaw to
  examine potentially sensitive information from the kernel's stack memory.
  (CVE-2013-3222)

  An information leak was discovered in the Linux kernel's recvmsg path for
  ax25 address family. A local user could exploit this flaw to examine
  potentially sensitive information from the kernel's stack memory.
  (CVE-2013-3223)

  An information leak was discovered in the Linux kernel's recvmsg path for
  the bluetooth address family. A local user could exploit this flaw to
  examine potentially sensitive information from the kernel's stack memory.
  (CVE-2013-3224)

  An information leak was discovered in the Linux kernel's bluetooth rfcomm
  protocol support. A local user could exploit this flaw to examine
  potentially sensitive information from the kernel's stack memory.
  (CVE-2013-3225)

  An information leak was discovered in the Linux kernel's Rose X.25 protocol
  layer. A local user could exploit this flaw to examine potentially
  sensitive information from the kernel's stack memory. (CVE-2013-3234)

  An information leak was discovered in the Linux kernel's TIPC (Transparent
  Inter Process Communication) protocol implementation. A local user could
  exploit this flaw to examine potentially sensitive information from the
  kernel's stack memory. (CVE-2013-3235)");
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}


include("pkg-lib-deb.inc");

release = dpkg_get_ssh_release();

res = "";
if(release == NULL){
  exit(0);
}

if(release == "UBUNTU13.04")
{

  if ((res = isdpkgvuln(pkg:"linux-image-3.5.0-226-omap4", ver:"3.5.0-226.39", rls:"UBUNTU13.04")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}