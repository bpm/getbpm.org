# Not sure why the default setup in RubyGems doesn't cut it,
# but this should make us safe without losing any of the original
# intentions.

class Gem::Requirement
  private
    def fix_syck_default_key_in_requirements
      # Fixup the Syck DefaultKey bug
      @requirements.each do |r|
        if (defined?(YAML::Syck::DefaultKey) && r[0].kind_of?(YAML::Syck::DefaultKey)) ||
            (defined?(Syck::DefaultKey) && r[0].kind_of?(Syck::DefaultKey))
          r[0] = "="
        end
      end
    end
end
