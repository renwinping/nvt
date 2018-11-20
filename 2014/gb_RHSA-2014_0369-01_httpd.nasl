###############################################################################
# OpenVAS Vulnerability Test
#
# RedHat Update for httpd RHSA-2014:0369-01
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.871152");
  script_version("$Revision: 12382 $");
  script_tag(name:"last_modification", value:"$Date: 2018-11-16 12:51:56 +0100 (Fri, 16 Nov 2018) $");
  script_tag(name:"creation_date", value:"2014-04-08 12:09:28 +0530 (Tue, 08 Apr 2014)");
  script_cve_id("CVE-2013-6438", "CVE-2014-0098");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_name("RedHat Update for httpd RHSA-2014:0369-01");


  script_tag(name:"affected", value:"httpd on Red Hat Enterprise Linux (v. 5 server)");
  script_tag(name:"insight", value:"The httpd packages provide the Apache HTTP Server, a powerful, efficient,
and extensible web server.

It was found that the mod_dav module did not correctly strip leading white
space from certain elements in a parsed XML. In certain httpd
configurations that use the mod_dav module (for example when using the
mod_dav_svn module), a remote attacker could send a specially crafted DAV
request that would cause the httpd child process to crash or, possibly,
allow the attacker to execute arbitrary code with the privileges of the
'apache' user. (CVE-2013-6438)

A buffer over-read flaw was found in the httpd mod_log_config module.
In configurations where cookie logging is enabled (on Red Hat Enterprise
Linux it is disabled by default), a remote attacker could use this flaw to
crash the httpd child process via an HTTP request with a malformed cookie
header. (CVE-2014-0098)

All httpd users are advised to upgrade to these updated packages, which
contain backported patches to correct these issues. After installing the
updated packages, the httpd daemon will be restarted automatically.");
  script_tag(name:"solution", value:"Please Install the Updated Packages.");
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name:"RHSA", value:"2014:0369-01");
  script_xref(name:"URL" , value:"https://www.redhat.com/archives/rhsa-announce/2014-April/msg00011.html");
  script_tag(name:"summary", value:"The remote host is missing an update for the 'httpd'
  package(s) announced via the referenced advisory.");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_family("Red Hat Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/rhel", "ssh/login/rpms", re:"ssh/login/release=RHENT_5");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = rpm_get_ssh_release();
if(!release) exit(0);

res = "";

if(release == "RHENT_5")
{

  if ((res = isrpmvuln(pkg:"httpd", rpm:"httpd~2.2.3~85.el5_10", rls:"RHENT_5")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"httpd-debuginfo", rpm:"httpd-debuginfo~2.2.3~85.el5_10", rls:"RHENT_5")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"httpd-devel", rpm:"httpd-devel~2.2.3~85.el5_10", rls:"RHENT_5")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"httpd-manual", rpm:"httpd-manual~2.2.3~85.el5_10", rls:"RHENT_5")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"mod_ssl", rpm:"mod_ssl~2.2.3~85.el5_10", rls:"RHENT_5")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}