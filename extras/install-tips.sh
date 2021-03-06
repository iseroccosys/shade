#!/bin/bash
# Copyright (c) 2017 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

for lib in \
        python-novaclient \
        python-keystoneclient \
        python-ironicclient \
        os-client-config \
        keystoneauth
do
    egg=$(echo $lib | tr '-' '_' | sed 's/python-//')
    if [ -d /opt/stack/new/$lib ] ; then
        tip_location="git+file:///opt/stack/new/$lib#egg=$egg"
        echo "$(which pip) install -U -e $tip_location"
        pip uninstall -y $lib
        pip install -U -e $tip_location
    else
        echo "$lib not found in /opt/stack/new/$lib"
    fi
done
