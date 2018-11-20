###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_RHSA-2017_1931-01_bash.nasl 12380 2018-11-16 11:03:48Z cfischer $
#
# RedHat Update for bash RHSA-2017:1931-01
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.871874");
  script_version("$Revision: 12380 $");
  script_tag(name:"last_modification", value:"$Date: 2018-11-16 12:03:48 +0100 (Fri, 16 Nov 2018) $");
  script_tag(name:"creation_date", value:"2017-08-04 12:46:12 +0530 (Fri, 04 Aug 2017)");
  script_cve_id("CVE-2016-0634", "CVE-2016-7543", "CVE-2016-9401");
  script_tag(name:"cvss_base", value:"7.2");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"qod_type", value:"package");
  script_name("RedHat Update for bash RHSA-2017:1931-01");
  script_tag(name:"summary", value:"The remote host is missing an update for the 'bash'
  package(s) announced via the referenced advisory.");
  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");
  script_tag(name:"insight", value:"The bash packages provide Bash (Bourne-again
  shell), which is the default shell for Red Hat Enterprise Linux. Security
  Fix(es): * An arbitrary command injection flaw was found in the way bash
  processed the hostname value. A malicious DHCP server could use this flaw to
  execute arbitrary commands on the DHCP client machines running bash under
  specific circumstances. (CVE-2016-0634) * An arbitrary command injection flaw
  was found in the way bash processed the SHELLOPTS and PS4 environment variables.
  A local, authenticated attacker could use this flaw to exploit poorly written
  setuid programs to elevate their privileges under certain circumstances.
  (CVE-2016-7543) * A denial of service flaw was found in the way bash handled
  popd commands. A poorly written shell script could cause bash to crash resulting
  in a local denial of service limited to a specific bash session. (CVE-2016-9401)
  Additional Changes: For detailed information on changes in this release, see the
  Red Hat Enterprise Linux 7.4 Release Notes linked from the References section.");
  script_tag(name:"affected", value:"bash on Red Hat Enterprise Linux Server (v. 7)");
  script_tag(name:"solution", value:"Please Install the Updated Packages.");

  script_xref(name:"RHSA", value:"2017:1931-01");
  script_xref(name:"URL" , value:"https://www.redhat.com/archives/rhsa-announce/2017-August/msg00022.html");
  script_tag(name:"solution_type", value:"VendorFix");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Red Hat Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/rhel", "ssh/login/rpms", re:"ssh/login/release=RHENT_7");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = rpm_get_ssh_release();
if(!release) exit(0);

res = "";

if(release == "RHENT_7")
{

  if ((res = isrpmvuln(pkg:"bash", rpm:"bash~4.2.46~28.el7", rls:"RHENT_7")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"bash-debuginfo", rpm:"bash-debuginfo~4.2.46~28.el7", rls:"RHENT_7")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}