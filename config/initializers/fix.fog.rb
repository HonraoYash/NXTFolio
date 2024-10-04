# config/initializers/fix_fog.rb
module CarrierWave
    module Storage
      # rubocop:disable Lint/EmptyClass
      class Fog
        # class Fog
        #   # Pending implementation
        # end
      end
      # rubocop:enable Lint/EmptyClass
    end
end
  