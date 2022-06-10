module Fastlane
  module Actions
    module SharedValues
      JACOCO_FLAVOR = :JACOCO_FLAVOR
      JACOCO_BUILD_TYPE = :JACOCO_BUILD_TYPE
    end

    class JacocoGradleAction < Action
      def self.run(params)
        flavor = params[:flavor]
        build_type = params[:build_type]

        # Declare name off gradle task
        # Example name task report JaCoCo: testDevelopDebugUnitTestCoverage
        # see details in file:
        #
        #     jacoco.gradle
        #
        gradle_task = ["test", flavor, build_type, "UnitTestCoverage"].join

        # Access lane context values
        Actions.lane_context[SharedValues::JACOCO_BUILD_TYPE] = build_type
        Actions.lane_context[SharedValues::JACOCO_FLAVOR] = flavor

        Fastlane::Actions::GradleAction.run(task: gradle_task, project_dir: '.')
      end

      def self.description
        "--------Creates JaCoCo test coverage report--------"
      end

      # Function details all the available parameters
      # that the user is able to include in his/her call to this action,
      # wrapped within a FastlaneCore:: ConfigItem.new() block
      # see details:
      #
      #     https://www.rubydoc.info/gems/fastlane_core/0.48.0/FastlaneCore/ConfigItem
      #
      def self.available_options
        [
        FastlaneCore::ConfigItem.new(
          key: :flavor,
          env_name: 'FL_JACOCO_FLAVOR',
          description: 'The flavor that you want the task for, example: `Develop`'),
        FastlaneCore::ConfigItem.new(
          key: :build_type,
          env_name: 'FL_JACOCO_BUILD_TYPE',
          description: 'The build type that you want the task for, example: `Debug` or `Release`',
          optional: true,
          default_value: 'Debug')
        ]
      end

      def self.return_value
        '--------End JaCoCo report--------'
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
