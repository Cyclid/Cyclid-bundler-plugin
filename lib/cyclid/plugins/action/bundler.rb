# frozen_string_literal: true
# Copyright 2016 Liqwyd Ltd.
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

# Top level module for the core Cyclid code.
module Cyclid
  # Module for the Cyclid API
  module API
    # Module for Cyclid Plugins
    module Plugins
      # "Bundler" plugin; wraps the command plugin to run commands under
      # "bundle exec"
      class Bundler < Action
        Cyclid.logger.debug 'in the Bundler plugin'

        def initialize(args = {})
          args.symbolize_keys!

          # At a bare minimum there has to be a command to execute.
          raise 'a command action requires a command' unless args.include? :cmd

          # Prepend 'bundle exec' and pass it through to the 'command' plugin
          args[:cmd] = "bundle exec #{args[:cmd]}"

          plugin = Cyclid.plugins.find('command', Cyclid::API::Plugins::Action)
          @command = plugin.new(args)
        end

        # Reflect methods to the command plugin
        def perform(log)
          @command.perform(log)
        end

        def prepare(args)
          @command.prepare(args)
        end

        # Register this plugin
        register_plugin 'bundler'
      end
    end
  end
end
