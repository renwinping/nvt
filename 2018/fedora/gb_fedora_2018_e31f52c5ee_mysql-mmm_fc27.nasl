###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_fedora_2018_e31f52c5ee_mysql-mmm_fc27.nasl 9863 2018-05-16 12:29:42Z santu $
#
# Fedora Update for mysql-mmm FEDORA-2018-e31f52c5ee
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2018 Greenbone Networks GmbH, http://www.greenbone.net
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.874465");
  script_version("$Revision: 9863 $");
  script_tag(name:"last_modification", value:"$Date: 2018-05-16 14:29:42 +0200 (Wed, 16 May 2018) $");
  script_tag(name:"creation_date", value:"2018-05-16 05:54:40 +0200 (Wed, 16 May 2018)");
  script_cve_id("CVE-2017-14474", "CVE-2017-14481");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"qod_type", value:"package");
  script_name("Fedora Update for mysql-mmm FEDORA-2018-e31f52c5ee");
  script_tag(name:"summary", value:"Check the version of mysql-mmm");
  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present 
on the target host.");
  script_tag(name:"insight", value:"MMM (MySQL Master-Master Replication Manager) 
is a set of flexible scripts to perform monitoring/failover and management of 
MySQL Master-Master replication configurations (with only one node writable at 
any time). The toolset also has the ability to read balance standard master/slave
configurations with any number of slaves, so you can use it to move virtual
IP addresses around a group of servers depending on whether they are behind
in replication. In addition to that, it also has scripts for data backups,
resynchronization between nodes etc.
");
  script_tag(name:"affected", value:"mysql-mmm on Fedora 27");
  script_tag(name:"solution", value:"Please install the updated packages.");

  script_xref(name:"FEDORA", value:"2018-e31f52c5ee");
  script_xref(name:"URL" , value:"https://lists.fedoraproject.org/archives/list/package-announce%40lists.fedoraproject.org/message/SIVKD3NXLPQWST3UWFMO5Q7UUHGHG6TC");
  script_tag(name:"solution_type", value:"VendorFix");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms");
  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "FC27")
{

  if ((res = isrpmvuln(pkg:"mysql-mmm", rpm:"mysql-mmm~2.2.1~20.fc27", rls:"FC27")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}