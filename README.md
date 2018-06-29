# ForemanSpacewalk

This is a plugin for [Foreman](https://github.com/theforeman/foreman) that allows to clean up hosts in a Spacewalk installation when they are removed in Foreman.
Spacewalk is an open source server management tool and downstream for RedHat Satellite 5 and SUSE Manager.

## Compatibility

| Foreman Version | Plugin Version |
| --------------- | -------------- |
| >= 1.15         | ~> 0.1         |
| >= 1.17         | ~> 1.0         |
| >= 1.18         | ~> 2.0         |

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins.

## Usage

First of all, you need to set up the smart proxy spacewalk plug-in.
If you set up a new host to act as a dedicated spacewalk smart proxy,
add this host as a SmartProxy. If you used an existing smart proxy host
and just added the plugin there, refresh the smart proxy in Foreman's UI.

To use the spacewalk server as a content source for Foreman, just set
it up as a new installation media. The path for a SUSE Manager and SUSE Linux
operatingsystem can look like this:
`http://spacewalk.example.com/ks/dist/sles$majorsp$minor_installation/`.

If you want Foreman to remove the host in Spacewalk, when you remove the host
in Foreman, the host needs to have a spacewalk proxy set. You can add a spacewalk
proxy in the create or edit host form.

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2018 dm-drogerie markt GmbH & Co. KG, https://dm.de

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
