###############################################################################
# OpenVAS Vulnerability Test
#
# RedHat Update for dracut RHSA-2013:1674-02
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.871086");
  script_version("$Revision: 12382 $");
  script_tag(name:"last_modification", value:"$Date: 2018-11-16 12:51:56 +0100 (Fri, 16 Nov 2018) $");
  script_tag(name:"creation_date", value:"2013-11-21 10:44:38 +0530 (Thu, 21 Nov 2013)");
  script_cve_id("CVE-2012-4453");
  script_tag(name:"cvss_base", value:"2.1");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:P/I:N/A:N");
  script_name("RedHat Update for dracut RHSA-2013:1674-02");


  script_tag(name:"affected", value:"dracut on Red Hat Enterprise Linux Desktop (v. 6),
  Red Hat Enterprise Linux Server (v. 6),
  Red Hat Enterprise Linux Workstation (v. 6)");
  script_tag(name:"insight", value:"The dracut packages include an event-driven initramfs generator
infrastructure based on the udev device manager. The virtual file system,
initramfs, is loaded together with the kernel at boot time and initializes
the system, so it can read and boot from the root partition.

It was discovered that dracut created initramfs images as world readable.
A local user could possibly use this flaw to obtain sensitive information
from these files, such as iSCSI authentication passwords, encrypted root
file system crypttab passwords, or other information. (CVE-2012-4453)

This issue was discovered by Peter Jones of the Red Hat Installer Team.

These updated dracut packages include numerous bug fixes and two
enhancements. Space precludes documenting all of these changes in this
advisory. Users are directed to the Red Hat Enterprise Linux 6.5 Technical
Notes, linked to in the References, for information on the most significant
of these changes.

All dracut users are advised to upgrade to these updated packages, which
contain backported patches to correct these issues and add these
enhancements.");
  script_tag(name:"solution", value:"Please Install the Updated Packages.");
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name:"RHSA", value:"2013:1674-02");
  script_xref(name:"URL" , value:"https://www.redhat.com/archives/rhsa-announce/2013-November/msg00033.html");
  script_tag(name:"summary", value:"The remote host is missing an update for the 'dracut'
  package(s) announced via the referenced advisory.");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 Greenbone Networks GmbH");
  script_family("Red Hat Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/rhel", "ssh/login/rpms", re:"ssh/login/release=RHENT_6");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = rpm_get_ssh_release();
if(!release) exit(0);

res = "";

if(release == "RHENT_6")
{

  if ((res = isrpmvuln(pkg:"dracut", rpm:"dracut~004~336.el6", rls:"RHENT_6")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"dracut-fips", rpm:"dracut-fips~004~336.el6", rls:"RHENT_6")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"dracut-kernel", rpm:"dracut-kernel~004~336.el6", rls:"RHENT_6")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"dracut-network", rpm:"dracut-network~004~336.el6", rls:"RHENT_6")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}
