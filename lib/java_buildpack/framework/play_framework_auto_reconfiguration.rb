# Encoding: utf-8
# Cloud Foundry Java Buildpack
# Copyright 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'java_buildpack/component/versioned_dependency_component'
require 'java_buildpack/framework'
require 'java_buildpack/util/play/factory'

module JavaBuildpack
  module Framework

    # Encapsulates the functionality for enabling cloud auto-reconfiguration in Play applications. Note that Spring auto-
    # reconfiguration is covered by the SpringAutoReconfiguration framework. The reconfiguration performed here is to
    # override Play application configuration to bind a Play application to cloud resources.
    class PlayFrameworkAutoReconfiguration < JavaBuildpack::Component::VersionedDependencyComponent

      # (see JavaBuildpack::Component::BaseComponent#compile)
      def compile
        download_jar
        @droplet.additional_libraries << (@droplet.sandbox + jar_name)
      end

      # (see JavaBuildpack::Component::BaseComponent#release)
      def release
        @droplet.additional_libraries << (@droplet.sandbox + jar_name)
      end

      protected

      # (see JavaBuildpack::Component::VersionedDependencyComponent#supports?)
      def supports?
        @configuration['enabled'] && JavaBuildpack::Util::Play::Factory.create(@droplet)
      end

    end

  end
end
