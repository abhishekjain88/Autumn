#!/bin/sh

#
# Copyright 2016 Intuit
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case "$1" in
  purge|remove)
    for dir in "/etc/init.d/${application.name}" "${application.home}" "${log.dir}"; do
      /bin/rm -rf $dir
    done
    getent passwd ${application.user} >/dev/null && userdel -f ${application.user}
    getent group ${application.group} >/dev/null && groupdel ${application.group}
    # note: needed to swallow the !0 response code
    s=$?
    ;;
  abort-install|abort-upgrade|upgrade|failed-upgrade|disappear)
    ;;
  *)
    echo "`basename $0` called with unknown argument: $1" >&2
    ;;
esac
