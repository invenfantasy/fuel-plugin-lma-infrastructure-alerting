#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
class lma_infra_alerting::params {

  ## Default configuration of Nagios
  #
  $nagios_http_user = 'nagiosadmin'
  $nagios_http_password = ''
  $nagios_http_port = 8001
  $nagios_cmd_check_ssh = 'check_ssh'

  $nagios_contactgroup = 'openstack'
  $nagios_contact_email = 'root@localhost'

  # All configuration files for nagios will be prepended with this prefix
  $nagios_config_filename_prefix = 'lma_'

  ## Override Nagios server configuration
  #
  # Nagios check periodically all commands received by HTTP.
  # We must enable external command and and its frequency must be coherent with
  # the service status forwarded by the LMA collector.
  $nagios_check_external_commands = true
  $nagios_command_check_interval = '10s'
  # The 'time unit' for all check_interval and check_retry (service and host).
  $nagios_interval_length = '60'
  $nagios_check_service_freshness = true
  $nagios_enable_notifications = true
  $nagios_accept_passive_service_checks = true

  # Following parameters are not mandatory but are usefull and better for LMA
  $nagios_accept_passive_host_checks = false
  $nagios_use_syslog = true
  $nagios_enable_flap_detection = true
  $nagios_debug_level = 0
  $nagios_process_performance_data = false

  ## Service statutes
  #
  # Following parameters check and retry intervals are the number of
  # "time units" to wait before scheduling a (re)check.
  # (see $nagios_interval_length)
  $nagios_check_interval_service_status = 1
  # Send notifications not before 2 check attempts (avoid flapping)
  $nagios_max_check_attempts_service_status = 2
  # Force an active check (to force UNKNOWN state) if LMA Collector doesn't
  # push status since the last minute + 5 seconds.
  # Additional 5 seconds is IMPORTANT to avoid flapping when restarting heka,
  # because  statutes are not sent during the first minute (pacemaker check)
  $nagios_freshness_threshold_service_status = 65
  $nagios_generic_host_template = 'generic-host'
  $nagios_generic_service_template = 'generic-service'

  ## Important parameters to maintain coherent with the LMA Collector
  #
  # Following service names must be coherent with the
  # nagios encoder plugin names.
  $openstack_core_services = [
      'openstack.horizon.status',
      'openstack.keystone.status',
      'openstack.nova.status',
      'openstack.glance.status',
      'openstack.cinder.status',
      'openstack.neutron.status',
      'openstack.heat.status',
  ]

  # The hostname must match with
  # lma_collector::params::nagios_hostname_service_status.
  # The numeric prefix is used to orderer the display in Nagios UI
  $nagios_openstack_hostname_prefix = '00-openstack-services'
}
