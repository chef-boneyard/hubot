#
# Cookbook Name:: hubot
# Attributes:: supervisor
#
# Copyright (c) 2013, Seth Chisamore
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Supervisor stuff
default['hubot']['supervisor']['stdout_logfile'] = "/var/log/hubot.log"
default['hubot']['supervisor']['stdout_logfile_maxbytes'] = "10MB"
default['hubot']['supervisor']['stdout_logfile_backups'] = 10
default['hubot']['supervisor']['stderr_logfile'] = "/var/log/hubot_error.log"
default['hubot']['supervisor']['stderr_logfile_maxbytes'] = "10MB"
default['hubot']['supervisor']['stderr_logfile_backups'] = 10
