class Package
  class << self
    def implementation(implementation)
      self.send(implementation.patch.language, implementation)
    end

    def javascript(implementation)
      <<-JAVASCRIPT
  (function() {
    #{indent(implementation.source, 4)}
    
    __context__.#{implementation.patch.name} = #{implementation.patch.name};
  }());
      JAVASCRIPT
    end

    def indent(source, indentation)
      indented_lines = source.lines.each_with_index.map do |line, index|
        if index == 0
          line
        else
          (' ' * indentation) + line
        end
      end

      indented_lines.join('')
    end
  end
end
