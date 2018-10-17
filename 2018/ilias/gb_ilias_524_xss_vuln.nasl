##############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ilias_524_xss_vuln.nasl 9900 2018-05-18 07:57:02Z asteins $
#
# ILIAS < 5.2.4 XSS Vulnerability
#
# Authors:
# Adrian Steins <adrian.steins@greenbone.net>
#
# Copyright:
# Copyright (c) 2018 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.112192");
  script_version("$Revision: 9900 $");
  script_tag(name: "last_modification", value: "$Date: 2018-05-18 09:57:02 +0200 (Fri, 18 May 2018) $");
  script_tag(name: "creation_date", value: "2018-01-16 10:21:08 +0100 (Tue, 16 Jan 2018)");
  script_tag(name: "cvss_base", value: "4.3");
  script_tag(name: "cvss_base_vector", value: "AV:N/AC:M/Au:N/C:N/I:P/A:N");

  script_cve_id("CVE-2018-5688");

  script_tag(name: "qod_type", value: "remote_banner");

  script_tag(name: "solution_type", value: "VendorFix");

  script_name("ILIAS < 5.2.4 XSS Vulnerability");

  script_category(ACT_GATHER_INFO);

  script_copyright("This script is Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("gb_ilias_detect.nasl");
  script_mandatory_keys("ilias/installed");

  script_tag(name: "summary", value: "ILIAS eLearning before version 5.2.4 is prone to a cross-site scripting (XSS) vulnerability.");

  script_tag(name: "insight", value: "Cross-site scripting exists via the cmd parameter to the displayHeader function in setup/classes/class.ilSetupGUI.php in the Setup component.");

  script_tag(name: "vuldetect", value: "Checks the version.");

  script_tag(name: "affected", value: "ILIAS up to and including version 5.2.3.");

  script_tag(name: "solution", value: "Update to version 5.2.4 or later.");

  script_xref(name: "URL", value: "https://www.ilias.de/docu/goto_docu_pg_75029_35.html");

  exit(0);
}

include("host_details.inc");
include("version_func.inc");

CPE = "cpe:/a:ilias:ilias";

if (!port = get_app_port(cpe: CPE))
  exit(0);

if (!version = get_app_version(cpe: CPE, port: port))
  exit(0);

if (version_is_less(version: version, test_version: "5.2.4")) {
  report = report_fixed_ver(installed_version: version, fixed_version: "5.2.4");
  security_message(port: port, data: report);
  exit(0);
}

exit(99);